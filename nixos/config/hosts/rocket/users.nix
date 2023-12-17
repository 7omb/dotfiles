{ config, lib, pkgs, ... }:

{
  users.users.tom.extraGroups = [
    "networkmanager"
    "wireshark"
  ];

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
        nodejs-18_x
        python311
        racket
        rustup
        shellcheck
        sqlite
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
