#!/bin/sh
sudo nix-channel --update
sudo nixos-rebuild switch -I nixos-config=$HOME/git/dotfiles/nixos/config/configuration.nix
