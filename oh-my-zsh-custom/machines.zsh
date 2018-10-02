if type go > /dev/null; then
    CUSTOM_DIR=$HOME/Projects/go
    if [ -d "$CUSTOM_DIR" ]; then
        export GOPATH=$CUSTOM_DIR
    fi
    export PATH=$PATH:$(go env GOPATH)/bin
fi

[ $(uname) = 'Darwin' ] && alias ctags="$(brew --prefix)/bin/ctags"
[ $(uname) = 'Darwin' ] && export PATH="/usr/local/opt/llvm/bin:$PATH"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ "$(hostname)" = "Klappschloss" ] && export PATH="$PATH:$HOME/git/zeug_cmk/bin"
[ "$(hostname)" = "Klappschloss" ] && export PYTHONPATH="$PYTHONPATH:$HOME/git/check_mk"
