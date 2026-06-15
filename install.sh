#!/usr/bin/env bash

set -euo pipefail

dir="$HOME/.config"
stamp="$(date +%Y%m%d-%H%M%S)"

usage() {
  cat <<EOF

usage: ${0##*/} [flags] [options]

  Options:

    --install, -i			 Install all dotfiles (i3wm/Hyprland)
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
  backup_path "$dir/i3"
  backup_path "$dir/hypr"
  backup_path "$dir/polybar"
  backup_path "$dir/alias"
  backup_path "$dir/bin"
  backup_path "$dir/pictures"
  backup_path "$dir/zsh"
  backup_path "$HOME/.zshrc"
}

set_copy() {
  set_backup

  mkdir -p "$dir"
  cp -R .config/i3 "$dir/"
  cp -R .config/hypr "$dir/"
  cp -R .config/polybar "$dir/"
  cp -R .config/alias "$dir/"
  cp -R .config/bin "$dir/"
  cp -R .config/pictures "$dir/"
  cp -R .config/zsh "$dir/"
  cp -f .config/.touchpad.sh "$dir/.touchpad.sh"
  cp -f zshrc "$HOME/.zshrc"
  chmod +x "$dir"/.touchpad.sh "$dir"/bin/* "$dir"/polybar/launch.sh "$dir"/polybar/scripts/*
}

case "$1" in
  "--install"|"-i") set_copy;;
  "--help"|"-h") usage;;
  *) echo "Invalid option" && usage;;
esac
