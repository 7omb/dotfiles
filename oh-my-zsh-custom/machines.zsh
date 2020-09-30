if type go > /dev/null; then
    CUSTOM_DIR=$HOME/Projects/go
    if [ -d "$CUSTOM_DIR" ]; then
        export GOPATH=$CUSTOM_DIR
    fi
    export PATH=$PATH:$(go env GOPATH)/bin
fi

if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

[ "$(hostname)" = "klappschloss" ] && export PATH="$PATH:$HOME/git/zeug_cmk/bin"
