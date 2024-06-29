{ config, lib, pkgs, ... }:

let
  homeAssistantVersion = "2024.6.4";
in
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

  networking.firewall.allowedTCPPorts = [ 8123 ];
  hardware.bluetooth.enable = true;
  virtualisation.oci-containers = {
    backend = "podman";
    containers.homeassistant = {
      volumes = [
        "home-assistant:/config"
        "/run/dbus:/run/dbus:ro"
      ];
      environment.TZ = "Europe/Amsterdam";
      image = "ghcr.io/home-assistant/home-assistant:${homeAssistantVersion}";
      extraOptions = [
        "--network=host"
      ];
    };
  };

  system.stateVersion = "23.11";
}
