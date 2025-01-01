{ config, lib, pkgs, ... }:

{
  users.users.tom.extraGroups = [
    "networkmanager"
    "wireshark"
  ];

  services = {
    xserver = {
      enable = true;
      exportConfiguration = true;
      layout = "us";
      xkbOptions = "compose:caps";
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
      displayManager.defaultSession = "xfce";
    };

    upower.enable = true;
  };

  fonts.packages = with pkgs; [
    source-code-pro
  ];

  environment.systemPackages = with pkgs; [
    # XFCE
    moka-icon-theme
    networkmanagerapplet
    xfce.thunar-volman
    xfce.xfce4-battery-plugin
    xfce.xfce4-cpufreq-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-whiskermenu-plugin
    xsel

    # applications
    evince                # PDF viewer
    simple-scan           # scanning
    libreoffice           # office
    vlc                   # video
    imagemagick           # images
  ];

  programs = {
    ssh.startAgent = true;
  };

  home-manager = {
    users.tom = { pkgs, ... }: {
      xdg.enable = true;

      home.packages = with pkgs; [
        brave
        gcc
        cabal2nix
        dbeaver-bin
        entr
        haskellPackages.ghc
        haskellPackages.stack
        ihp-new
        python313
        rustup
        shellcheck
        sqlite
        zeal
      ];

      programs = {
        git = {
          enable = true;
          userName = "Tom Bärwinkel";
          userEmail = "dev@baerwinkel.org";
        };

        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        emacs = {
          enable = true;
          package = pkgs.emacs30;
          extraPackages = (epkgs: [ epkgs.vterm ]);
        };

        fzf = {
          enable = true;
          enableZshIntegration = true;
          tmux.enableShellIntegration = true;
        };
      };

      services.emacs = {
        enable = true;
        startWithUserSession = "graphical";
      };

      home.stateVersion = "18.09";
    };

    # Install packages to /etc/profiles (default is ~/.nix-profile)
    useUserPackages = true;

    # Use the global pkgs that is configured via the system level nixpkgs options
    # This saves an extra Nixpkgs evaluation, adds consistency, and removes the
    # dependency on NIX_PATH, which is otherwise used for importing Nixpkgs.
    useGlobalPkgs = true;
  };
}
