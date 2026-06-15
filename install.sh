#!/usr/bin/env bash

set -euo pipefail

dir="$HOME/.config"
stamp="$(date +%Y%m%d-%H%M%S)"

usage() {
  cat <<EOF

usage: ${0##*/} [flags] [options]

  Options:

    --install, -i			 Install all dotfiles (I3/BSPWM)
    --help, -h				 Show this is message
EOF
}

if [[ -z $1 || $1 = @(-h|--help) ]]; then
  usage
  exit $(( $# ? 0 : 1 ))
fi

# move
backup_path() {
  local path="$1"

  if [ -e "$path" ] || [ -L "$path" ]; then
    mv -- "$path" "$path.bak-$stamp"
  fi
}

set_backup() {
  backup_path "$dir/bspwm"
  backup_path "$dir/i3"
  backup_path "$dir/polybar"
  backup_path "$dir/sxhkd"
  backup_path "$dir/alias"
  backup_path "$HOME/.zshrc"
  backup_path "$HOME/.xinitrc"
}

set_copy() {
  set_backup

  mkdir -p "$dir"
  cp -R .config/. "$dir/"
  cp -f zshrc "$HOME/.zshrc"
  cp -f .xinitrc "$HOME/.xinitrc"
  chmod +x "$dir"/bspwm/bspwmrc "$dir"/bspwm/autostart "$dir"/bspwm/dual_monitor "$dir"/.touchpad.sh "$dir"/bin/* "$dir"/polybar/launch.sh "$dir"/polybar/scripts/*
}

case "$1" in
  "--install"|"-i") set_copy;;
  "--help"|"-h") usage;;
  *) echo "Invalid option" && usage;;
esac
