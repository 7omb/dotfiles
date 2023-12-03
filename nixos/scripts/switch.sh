#!/usr/bin/env sh
sudo nixos-rebuild switch --flake "$HOME/git/dotfiles/nixos/config#$HOST"
