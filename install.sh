#!/bin/bash
dir="$HOME/.config"

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
set_backup(){

  if [ -d "$dir/bspwm" ]; then
    mv $dir/bspwm/* $dir/bspwm/*.bak
  fi

  if [ -d "$dir/i3" ]; then
    mv $dir/i3/* $dir/bspwm/*.bak
  fi

  if [ -d "$dir/polybar" ]; then
    mv $dir/polybar/* $dir/polybar/*.bak
  fi

  if [ -d "$dir/sxhkd" ]; then
    mv $dir/sxhkd/* $dir/sxhkd/*.bak
  fi

  if [ -f "$HOME/.zshrc" ]; then
    mv $HOME/.zshrc $HOME/.zshrc.bak
  fi
  
}

set_copy(){

  set_backup

  cp -r bspwm/* $dir/bspwm/
  cp -r i3/* $dir/i3/*
  cp -r polybar/* $dir/polybar/*
  cp -r sxhkd/* $dir/sxhkd/*
  cp -r zshrc $HOME/

  mv $HOME/zshrc $HOME/.zshrc
}

case "$1" in
  "--install"|"-i") set_copy;;
  "--help"|"-h") usage;;
  *) echo "Invalid option" && usage;;
esac
