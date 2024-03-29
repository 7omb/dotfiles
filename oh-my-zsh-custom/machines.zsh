if type go > /dev/null; then
    CUSTOM_DIR=$HOME/Projects/go
    if [ -d "$CUSTOM_DIR" ]; then
        export GOPATH=$CUSTOM_DIR
    fi
    export PATH=$PATH:$(go env GOPATH)/bin
fi

[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
