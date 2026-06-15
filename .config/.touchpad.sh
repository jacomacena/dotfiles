#!/usr/bin/env bash

set -euo pipefail

touchpad_id="$(xinput list | awk -F'id=' '/[Tt]ouchpad/ { split($2, a, /[[:space:]]/); print a[1]; exit }')"
[ -n "$touchpad_id" ] || exit 0

mouse_count="$(xinput list | awk '/slave[[:space:]]+pointer/ && /[Mm]ouse|USB|Logitech|Dell|Wireless/ && !/[Tt]ouchpad/ { count++ } END { print count + 0 }')"

if [ "$mouse_count" -gt 0 ]; then
    xinput disable "$touchpad_id"
else
    xinput enable "$touchpad_id"
fi
