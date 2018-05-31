if type go > /dev/null; then
    CUSTOM_DIR=$HOME/Projects/go
    if [ -d "$CUSTOM_DIR" ]; then
        export GOPATH=$CUSTOM_DIR
    fi
    export PATH=$PATH:$(go env GOPATH)/bin
fi

[ $(uname) = 'Darwin' ] && alias ctags="$(brew --prefix)/bin/ctags"

[ "$(hostname)" = "Klappschloss" ] && export PATH="$PATH:$HOME/git/zeug_cmk/bin"
