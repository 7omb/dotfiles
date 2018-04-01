[[ $- != *i* ]] && return

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=blinks
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
HIST_STAMPS=yyyy-mm-dd

plugins=(vi-mode history extract sudo git z)
source "$ZSH/oh-my-zsh.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
