[[ $- != *i* ]] && return

ZSH_TMUX_AUTOSTART=false
[[ $TMUX == "" ]] && tmux -2 new-session -A -s sesh

export ZSH=$HOME/.oh-my-zsh
export EDITOR=vim

ZSH_THEME=blinks
HIST_STAMPS=yyyy-mm-dd
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

plugins=(history vi-mode git)
source "$ZSH/oh-my-zsh.sh"
