{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file
    gnumake
    gnupg
    htop
    inxi # cli tool for system information
    inetutils
    jq
    lsof
    nethogs
    nmap
    pciutils
    powertop # cli tool to display power usage
    psmisc
    (ripgrep.override { withPCRE2 = true; })
    tmux
    tree
    unzip
    usbutils
  ];
}
