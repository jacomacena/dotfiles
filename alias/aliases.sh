#!/bin/bash

alias q='exit 0'
alias d='clear'
alias ls='ls --color=auto'
alias la='ls -AhF'
alias ll='ls -lAhF'
alias l.='ls -ld .*'

alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias debug="set -o nounset; set -o xtrace"
alias x='chmod +x'

alias du='du -sh'
alias df='df -kTh'

alias dd='dd status=progress'
alias _='sudo'
alias _i='sudo -i'
alias _s='sudo -s'
alias _find='sudo find'

if hash nvim >/dev/null 2>&1; then
    alias vim='nvim'
    alias v='nvim'
    alias sv='sudo nvim'
else
    alias v='vim'
    alias sv='sudo vim'
fi

alias f='ranger'

# GIT
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gp='git pull'
alias gf='git fetch'
alias gc='git clone'
alias gs='git stash'
alias gb='git branch'
alias gm='git merge'
alias gch='git checkout'
alias gcm='git commit -m'
alias glg='git log --stat'
alias gpo='git push origin HEAD'
alias gpm='git push origin master'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias _sshgit='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/ssh_git'

# PACMAN
alias pup='sudo pacman -Syyyyyuuuuu --noconfirm && yaourt -Syua' # update
alias pin='sudo pacman -S'    # install
alias pun='sudo pacman -Rs'   # remove
alias pcc='sudo pacman -Sc'  # clear cache
alias pls='pacman -Qs'        # list files
alias prm='sudo pacman -R --nosave --recursive' # really remove, configs and all

# MAKE
alias pkg='makepkg --printsrcinfo > .SRCINFO && makepkg -fsrc'
alias spkg='pkg --sign'
alias mk='make && make clean'
alias smk='sudo make clean install && make clean'
alias ssmk='sudo make clean install && make clean && rm -iv config.h'

# aliases inside tmux session
if [[ $TERM == *tmux* ]]; then
    alias :sp='tmux split-window'
    alias :vs='tmux split-window -h'
fi

alias rcp='rsync -v --progress'
alias rmv='rcp --remove-source-files'

alias mir='sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist --verbose'
alias mirbr='sudo reflector --country Brazil --sort rate --save /etc/pacman.d/mirrorlist --verbose'

alias gif='byzanz-record -x 1090 -w 750 -y 430 -h 480 -v -d 15 ~/Videos/$(date +%a-%d-%S).gif'
alias rec='ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -c:v libx264 -qp 0 -preset ultrafast ~/Videos/$(date +%a-%d-%S).mkv'

alias calc='python -qi -c "from math import *"'
alias brok='sudo find . -type l -! -exec test -e {} \; -print'
alias timer='time read -p "Press enter to stop"'

# shellcheck disable=2142
alias xp='xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

# REMOUNT MNT
alias _tmp='sudo mount -o remount,size=8G /tmp'