{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    tmpOnTmpfs = true;

    initrd.luks.devices = {
      crypted = {
        device = "/dev/disk/by-uuid/f70e042d-995b-418d-9c33-1591376bca02";
        preLVM = true;
      };
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.editor = false;  # fixes a security hole

      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
      };
    };

    kernel.sysctl = {
      # The Magic SysRq key is a key combo that allows users connected to the
      # system console of a Linux kernel to perform some low-level commands.
      # Disable it, since we don't need it, and is a potential security concern.
      "kernel.sysrq" = 0;

      ## TCP hardening
      # Prevent bogus ICMP errors from filling up logs.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      # Reverse path filtering causes the kernel to do source validation of
      # packets received from all interfaces. This can mitigate IP spoofing.
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      # Do not accept IP source route packets (we're not a router)
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      # Don't send ICMP redirects (again, we're on a router)
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;
      # Refuse ICMP redirects (MITM mitigations)
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      # Protects against SYN flood attacks
      "net.ipv4.tcp_syncookies" = 1;
      # Incomplete protection again TIME-WAIT assassination
      "net.ipv4.tcp_rfc1337" = 1;

      ## TCP optimization
      # TCP Fast Open is a TCP extension that reduces network latency by packing
      # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
      # both incoming and outgoing connections:
      "net.ipv4.tcp_fastopen" = 3;
      # Bufferbloat mitigations + slight improvement in throughput & latency
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
    };

    kernelModules = [ "tcp_bbr" ];
  };

  security = {
    protectKernelImage = true;
    apparmor.enable = true;
  };

  # Use functions keys first, media keys second for apple keyboard
  system.activationScripts = {
    hid_apple_fix.text = ''
      echo 2 | tee /sys/module/hid_apple/parameters/fnmode >/dev/null
    '';
  };

  time.timeZone = "Europe/Amsterdam";

  networking = {
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    hostName = "groot";
    networkmanager.enable = true;

    firewall.enable = true;
    # firewall.allowedTCPPorts = [  ];
    # firewall.allowedUDPPorts = [  ];

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
  # direct firmware load for regulatory.db
  hardware.firmware = [ pkgs.wireless-regdb ];
  # Below is a workaround to make wifi available from the start. The broadcom driver
  # seems to make problems, but works fine after a restart with nmcli.
  systemd.user.services.restart_networking = {
    script = ''
      nmcli networking off && nmcli networking on
    '';
    path = [ pkgs.networkmanager ];
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
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
      layout = "us";
      xkbOptions = "compose:caps";
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
      displayManager.defaultSession = "xfce";
    };

    printing.enable = true;  /* CUPS printing */
    # openssh.enable = true;  /* OpenSSH daemon */
  };


  hardware.cpu.intel.updateMicrocode = true;

  # Video acceleration for integrated intel graphics on Haswell CPU.
  # To verify support run:
  #   nix-shell -p libva-utils --run vainfo
  #   nix-shell -p vdpauinfo --run vdpauinfo
  # For further details see:
  #   https://wiki.archlinux.org/title/Intel_graphics
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.bluetooth = {
    enable = true;
    disabledPlugins = [ "sap" ];
  };
  services.blueman.enable = true;

  powerManagement.powertop.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC="schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT="schedutil";

      CPU_SCALING_MIN_FREQ_ON_AC = 800000;
      CPU_SCALING_MAX_FREQ_ON_AC = 2900000;
      CPU_SCALING_MIN_FREQ_ON_BAT = 800000;
      CPU_SCALING_MAX_FREQ_ON_BAT = 2400000;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tom = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    anki
    brave
    direnv
    emacs
    evince
    gnumake
    gnupg
    htop
    imagemagick
    inkscape
    inxi  /* cli tool for system information */
    jq
    libreoffice
    lightlocker  /* simple screen locker */
    lsof
    moka-icon-theme
    nethogs
    networkmanagerapplet
    nmap
    pciutils
    powertop  /* cli tool to display power usage */
    (ripgrep.override {withPCRE2 = true;})
    telnet
    tmux
    tree
    vim
    vlc
    wget
    xfce.xfce4-battery-plugin
    xfce.xfce4-cpufreq-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-whiskermenu-plugin
    xsel
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  fonts.fonts = with pkgs; [
    source-code-pro
  ];

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
  system.stateVersion = "21.05"; # Did you read the comment?

}
