{ config, lib, pkgs, ... }:

{
  nix.settings.trusted-users = [ "tom" ];

  users.users.tom = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOvTO/S+vWPkOb5ErhicEKWhzu1jJB/jUfzwrRoRIfTZ dev@baerwinkel.org"
    ];
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };
}
