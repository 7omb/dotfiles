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
      xkb.layout = "us";
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "tom";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    udisks2.enable = true;
    upower.enable = true;
  };

  fonts.packages = with pkgs; [
    source-code-pro
    nerdfonts   # some nice fonts and icons
  ];

  environment.systemPackages = with pkgs; [
    # hyprland setup:
    kitty         # terminal
    swww          # wallpaper
    waybar        # bar
    wofi          # launcher
    wleave        # logout script
    swaylock      # screen locker
    swayidle      # idle manager
    brightnessctl # backlight control
    pavucontrol   # pulse audio control
    slurp         # select screen region
    grim          # take screenshots
    swappy        # edit screenshots
    udiskie       # udisks2 front-end
    wl-clipboard  # clipboard utilities
    networkmanagerapplet   # nm tray
    swaynotificationcenter # notifications
    libnotify

    # applications
    evince                # PDF viewer
    system-config-printer # printer gui
    gnome.simple-scan     # scanning
    libreoffice           # office
    vlc                   # video
    imagemagick           # images
  ];

  security.pam.services.swaylock = {};

  programs = {
    hyprland = {
      enable = true;
      # enableNvidiaPatches = true;
      xwayland.enable = true;
    };

    ssh.startAgent = true;
  };

  # hint electron apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home-manager = {
    users.tom = { pkgs, ... }: {
      xdg = {
        enable = true;
      };

      home.packages = with pkgs; [
        brave
        chromium
        gcc
        cabal2nix
        dbeaver-bin
        elmPackages.elm
        entr # run a command when files change
        haskellPackages.ghc
        haskellPackages.stack
        idris2
        ihp-new
        jdk11
        nodejs-18_x
        python311
        racket
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
          package = pkgs.emacs29-pgtk;
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
