{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.enable = true;

  home = {
    username = "tom";
    homeDirectory = "/home/tom";

    packages = with pkgs; [
      cabal2nix
      cabal-install
      elmPackages.elm
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
  };

  programs.git = {
    enable = true;
    userName = "Tom Bärwinkel";
    userEmail = "dev@baerwinkel.org";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
