#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
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

if [[ $# -eq 0 || ${1:-} = @(-h|--help) ]]; then
  usage
  exit $(( $# ? 0 : 1 ))
fi

# move
backup_path() {
  local path="$1"

  if [ -e "$path" ] || [ -L "$path" ]; then
    mv -- "$path" "$path.bak-$stamp"
    printf 'backup: %s -> %s\n' "$path" "$path.bak-$stamp"
  fi
}

set_backup() {
  backup_path "$dir/i3"
  backup_path "$dir/bspwm"
  backup_path "$dir/sxhkd"
  backup_path "$dir/hypr"
  backup_path "$dir/polybar"
  backup_path "$dir/alias"
  backup_path "$dir/bin"
  backup_path "$dir/pictures"
  backup_path "$dir/zsh"
  backup_path "$HOME/.zshrc"
  backup_path "$HOME/.xinitrc"
}

set_copy() {
  set_backup

  mkdir -p "$dir"
  cp -R "$repo_dir/.config/i3" "$dir/"
  cp -R "$repo_dir/.config/bspwm" "$dir/"
  cp -R "$repo_dir/.config/sxhkd" "$dir/"
  cp -R "$repo_dir/.config/hypr" "$dir/"
  cp -R "$repo_dir/.config/polybar" "$dir/"
  cp -R "$repo_dir/.config/alias" "$dir/"
  cp -R "$repo_dir/.config/bin" "$dir/"
  cp -R "$repo_dir/.config/pictures" "$dir/"
  cp -R "$repo_dir/.config/zsh" "$dir/"
  cp -f "$repo_dir/.config/.touchpad.sh" "$dir/.touchpad.sh"
  cp -f "$repo_dir/zshrc" "$HOME/.zshrc"
  cp -f "$repo_dir/.xinitrc" "$HOME/.xinitrc"
  chmod +x "$dir"/.touchpad.sh "$dir"/bin/* "$dir"/polybar/launch.sh "$dir"/polybar/scripts/*
  printf 'installed dotfiles to %s\n' "$dir"
}

case "$1" in
  "--install"|"-i") set_copy;;
  "--help"|"-h") usage;;
  *) echo "Invalid option" && usage;;
esac
