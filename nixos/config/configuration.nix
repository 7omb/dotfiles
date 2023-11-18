{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./programs.nix
    # user account and home manager setup. Don't forget to set a password with ‘passwd’.
    ./users.nix
    ./security.nix
    # Use Home Manager as a NixOS module (add Channel with correct version before):
    # sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
    # sudo nix-channel --update
    <home-manager/nixos>
  ];

  # Activate nix flakes. For further information see e.g.:
  # https://christine.website/blog/nix-flakes-1-2022-02-21
  nix = {
    settings.allowed-users = [ "@wheel" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    # Use latest kernel to make wifi work with Intel AX201
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
  };

  time.timeZone = "Europe/Amsterdam";

  networking = {
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    hostName = "rocket";
    networkmanager.enable = true;

    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
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

  fonts.fonts = with pkgs; [ source-code-pro ];

  # NVIDIA graphics drivers are currently not working retry later:
  # https://nixos.wiki/wiki/Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;
    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;
    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      # Option A: Sync Mode
      # sync.enable = true;
      # Option B: Offload Mode
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  # Option B: Offload Mode
  environment.systemPackages = [(pkgs.writeShellScriptBin "nvidia-offload" ''
   export __NV_PRIME_RENDER_OFFLOAD=1
   export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
   export __GLX_VENDOR_LIBRARY_NAME=nvidia
   export __VK_LAYER_NV_optimus=NVIDIA_only
   exec -a "$0" "$@"
  '')];

  # Enable automatic updates
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
