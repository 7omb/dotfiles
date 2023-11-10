#!/usr/bin/env sh
sudo nix-collect-garbage --delete-old
nix-collect-garbage --delete-old
/run/current-system/bin/switch-to-configuration boot
