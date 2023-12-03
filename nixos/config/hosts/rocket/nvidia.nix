{ config, lib, pkgs, ... }:

{
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
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Option A: Offload Mode
  hardware.nvidia.prime.offload = {
    enable = true;
    enableOffloadCmd = true;
  };
  environment.systemPackages = [(pkgs.writeShellScriptBin "nvidia-offload" ''
   export __NV_PRIME_RENDER_OFFLOAD=1
   export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
   export __GLX_VENDOR_LIBRARY_NAME=nvidia
   export __VK_LAYER_NV_optimus=NVIDIA_only
   exec -a "$0" "$@"
  '')];
  # Option B: Sync Mode
  # hardware.nvidia.prime.sync.enable = true;
}
