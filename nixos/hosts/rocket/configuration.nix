{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./programs.nix
  ];


  security = {
    apparmor.enable = true;
    rtkit.enable = true;
  };

  boot = {
    # Use the latest kernel:
    # kernelPackages = pkgs.linuxPackages_latest;

    tmp.useTmpfs = true;

    initrd = {
      enable = true;
      systemd.enable = true;
    };

    loader = {
      timeout = 2;
      systemd-boot = {
        enable = true;
        editor = false; # fixes a security hole
      };
      efi.canTouchEfiVariables = true;
    };

    plymouth.enable = true;

    kernelModules = [ "tcp_bbr" ];

    # Resolves "Unknown Chipset" error from nouveau
    kernelParams = [ "nouveau.modeset=0" "quiet" "splash" ];

    # Enable sof-firmware for audio
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=1
    '';

    # blacklistedKernelModules = [];
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  time.timeZone = "Europe/Amsterdam";

  networking = {
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    hostName = "rocket";
    networkmanager.enable = true;

    firewall = {
      # allowedTCPPorts = [];
      # allowedUDPPorts = [];
    };

    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    printing.enable = true; # CUPS printing
    journald.extraConfig = "SystemMaxUse=1G";

    # openssh.enable = true;  /* OpenSSH daemon */
  };

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable automatic updates
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  system.stateVersion = "21.11";
}
