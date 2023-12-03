#!/bin/sh
nix flake update "$HOME/git/dotfiles/nixos/config"
sudo nixos-rebuild switch --flake "$HOME/git/dotfiles/nixos/config#$HOST"
