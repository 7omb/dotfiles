{ config, lib, pkgs, ... }:

{
  users.users.tom = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };

  home-manager = {
    users.tom = { pkgs, ... }: {
      xdg.enable = true;

      home.packages = with pkgs; [
        cabal2nix
        cabal-install
        elmPackages.elm
        entr # run a command when files change
        ghc
        (haskell-language-server.override { supportedGhcVersions = [ "8107" ]; })
        idris2
        nodejs-16_x
        pipenv
        python310
        racket
        rustup
        shellcheck
        sqlite
        stack
      ];

      programs.git = {
        enable = true;
        userName = "Tom Bärwinkel";
        userEmail = "dev@baerwinkel.org";
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
