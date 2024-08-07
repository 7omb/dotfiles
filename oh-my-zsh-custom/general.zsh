setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks

alias ec='emacsclient --create-frame --no-wait'
alias vi=vim
alias h='history'
alias t='less +F'
alias rg="rg --hidden --glob='!.git/'"

alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

bindkey '^N' clear-screen

function ddif {
    echo $(date -d "$1 days")
}

# show mode in shell
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}
