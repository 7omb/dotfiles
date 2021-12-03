#!/bin/sh
sudo nixos-rebuild switch -I nixos-config=$HOME/git/dotfiles/nixos/system/configuration.nix
