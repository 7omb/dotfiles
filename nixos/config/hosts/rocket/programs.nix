{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave
    chromium
    evince
    file
    gnome.simple-scan
    gnumake
    gnupg
    htop
    imagemagick
    inkscape
    inxi # cli tool for system information
    inetutils
    jq
    libreoffice
    lightlocker # simple screen locker
    lsof
    moka-icon-theme
    nethogs
    networkmanagerapplet
    nmap
    pciutils
    powertop # cli tool to display power usage
    (ripgrep.override { withPCRE2 = true; })
    tmux
    tree
    unzip
    usbutils
    vlc
    xfce.thunar-volman
    xfce.xfce4-battery-plugin
    xfce.xfce4-cpufreq-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-whiskermenu-plugin
    xsel
  ];

  programs = {
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };
}
