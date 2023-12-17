{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  networking = {
    hostName = "beetle";
    wireless.enable = true;  # wireless via wpa_supplicant.
  };

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  system.stateVersion = "23.11";
}
