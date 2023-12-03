{ config, pkgs, ... }:

{
  nix = {
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    package = pkgs.nixFlakes;
  };

  nixpkgs.config.allowUnfree = true;
}
