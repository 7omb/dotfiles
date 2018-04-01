export EDITOR=vim

[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"
[ "$(hostname)" = "Klappschloss" ] && PATH="$PATH:$HOME/git/zeug_cmk/bin"
export PATH
