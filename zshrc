[[ $- != *i* ]] && return

export EDITOR=vim
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=blinks
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
HIST_STAMPS=yyyy-mm-dd

plugins=(vi-mode history extract sudo git z pipenv)
source "$ZSH/oh-my-zsh.sh"

[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
