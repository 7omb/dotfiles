{ config, lib, pkgs, ... }:

{
  users.users.tom = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "wireshark" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    users.tom = { pkgs, ... }: {
      xdg.enable = true;

      home.packages = with pkgs; [
        gcc
        cabal2nix
        elmPackages.elm
        entr # run a command when files change
        haskellPackages.ghc
        haskellPackages.stack
        idris2
        jdk11
        nodejs-16_x
        pipenv
        python310
        racket
        rustup
        shellcheck
        sqlite
      ];

      programs.git = {
        enable = true;
        userName = "Tom Bärwinkel";
        userEmail = "dev@baerwinkel.org";
      };

      programs.direnv = {
        enable = true;
        nix-direnv = { enable = true; };
      };

      programs.emacs = {
        enable = true;
        extraPackages = (epkgs: [ epkgs.vterm ]);
      };
    };

    # Install packages to /etc/profiles (default is ~/.nix-profile)
    useUserPackages = true;

    # Use the global pkgs that is configured via the system level nixpkgs options
    # This saves an extra Nixpkgs evaluation, adds consistency, and removes the
    # dependency on NIX_PATH, which is otherwise used for importing Nixpkgs.
    useGlobalPkgs = true;
  };
}