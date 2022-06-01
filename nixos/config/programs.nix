{ config, lib, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    brave
    evince
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
    usbutils
    vim
    vlc
    wget
    xfce.thunar-volman
    xfce.xfce4-battery-plugin
    xfce.xfce4-cpufreq-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-whiskermenu-plugin
    xsel
  ];

  programs.zsh.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
