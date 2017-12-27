setopt auto_list

# extend lib/history.zsh history settings
setopt bang_hist
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks

alias vi=vim
alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias h='history'
alias t='less +F'

alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

bindkey fd vi-cmd-mode  # map jk to normal mode in vi-mode
bindkey '^N' clear-screen

[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"
[ -f ~/.fzf.zsh ] && source "$HOME/.fzf.zsh"

# show mode in shell
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1;;
            *.tar.gz) tar xvzf $1;;
            *.bz2) bunzip2 $1;;
            *.rar) unrar x $1;;
            *.gz) gunzip $1;;
            *.tar) tar xvf $1;;
            *.tbz2) tar xvjf $1;;
            *.tgz) tar xvzf $1;;
            *.zip) unzip $1;;
            *.Z) uncompress $1;;
            *.7z) 7z x $1;;
            *) echo "No idea how to extract this filetype";;
        esac
    else
        "'$1' is not a valid file!"
    fi
}

alias x=extract
