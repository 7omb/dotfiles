{ config, lib, pkgs, ... }:

{
  users.users.tom.extraGroups = [
    "networkmanager"
    "wireshark"
  ];

  services = {
    desktopManager.cosmic.enable = true;
    displayManager = {
      cosmic-greeter.enable = true;
      autoLogin = {
        enable = true;
        user = "tom";
      };
    };

    fwupd.enable = true;
    upower.enable = true;
  };

  fonts.packages = with pkgs; [
    source-code-pro
  ];

  environment.systemPackages = with pkgs; [
    # applications
    evince                # PDF viewer
    libreoffice           # office
    vlc                   # video
    imagemagick           # images

    wineWowPackages.waylandFull

    chromium
    android-tools
    openssh
  ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  programs.adb.enable = true;

  programs = {
    ssh.startAgent = true;
    nix-ld.enable = true;
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
        uv
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
