{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./programs.nix
    ./users.nix
  ];

  security.apparmor.enable = true;

  boot = {
    # Use the latest kernel:
    # kernelPackages = pkgs.linuxPackages_latest;

    tmp.useTmpfs = true;

    loader = {
      systemd-boot = {
        enable = true;
        editor = false; # fixes a security hole
      };
      efi.canTouchEfiVariables = true;
    };

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
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      exportConfiguration = true;
      layout = "us";
      xkbOptions = "compose:caps";
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
      displayManager.defaultSession = "xfce";
    };

    avahi = {
      enable = true;
      openFirewall = true;
    };
    printing.enable = true; # CUPS printing

    # openssh.enable = true;  /* OpenSSH daemon */
  };

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.tlp.enable = true;

  fonts.packages = with pkgs; [ source-code-pro ];

  # Enable automatic updates
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  system.stateVersion = "21.11";
}
