[[ $- != *i* ]] && return

export EDITOR=vim
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=intheloop
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
HIST_STAMPS=yyyy-mm-dd

plugins=(history extract sudo git z direnv docker fzf)
source "$ZSH/oh-my-zsh.sh"

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
