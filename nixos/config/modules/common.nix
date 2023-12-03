{ config, pkgs, ... }:

{
  nix = {
    settings.allowed-users = [ "@wheel" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;
}
