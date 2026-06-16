#!/usr/bin/env bash

set -euo pipefail

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

connected_outputs() {
    xrandr --query | awk '$2 == "connected" { print $1 }'
}

internal_monitor="$(connected_outputs | awk '/^(eDP|LVDS)/ { print; exit }')"
external_monitor="$(connected_outputs | awk '!/^(eDP|LVDS)/ { print; exit }')"

export MONITOR="${internal_monitor:-eDP-1}"
export EXTERNAL_MONITOR="${external_monitor:-HDMI-1}"

# Terminate already running bar instances
killall -q polybar || true

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar -q top -c "$DIR"/config.ini &

if [ -n "$external_monitor" ]; then
    polybar -q bottom -c "$DIR"/config.ini &
fi
