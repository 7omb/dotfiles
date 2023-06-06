{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "thunderbolt" "usbhid" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/db203bef-a852-4949-a673-6bd5940569e4";
    fsType = "btrfs";
    options = [ "subvol=nixos" "ssd" "compress=zstd" "noatime" "space_cache" ];
  };

  boot.initrd.luks.devices."luks".device =
    "/dev/disk/by-uuid/7f95d70d-0fad-48c8-8733-e6f109eaae9f";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/db203bef-a852-4949-a673-6bd5940569e4";
    fsType = "btrfs";
    options = [ "subvol=home" "ssd" "compress=zstd" "noatime" "space_cache" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
