[[ $- != *i* ]] && return

export EDITOR=vim
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=blinks
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
HIST_STAMPS=yyyy-mm-dd

plugins=(vi-mode history extract sudo git z)
source "$ZSH/oh-my-zsh.sh"

[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
    source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
    source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
