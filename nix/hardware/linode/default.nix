{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.levain.hardware.linode;
in {
  options = {
    levain.hardware.linode = {
      enable = lib.mkEnableOption {
        description = "Whether to enable Linode hardware support";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Taken from https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/scan/not-detected.nix
    # Not imported via modulesPath, since NixOS modules don't support conditional imports
    hardware.enableRedistributableFirmware = lib.mkDefault true;

    boot.initrd.availableKernelModules = ["virtio_pci" "virtio_scsi" "ahci" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [];
    boot.extraModulePackages = [];

    boot.kernelParams = ["console=ttyS0,19200n8"];
    boot.loader = {
      grub = {
        enable = true;
        forceInstall = true;
        device = "nodev";
        extraConfig = ''
          serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
          terminal_input serial;
          terminal_output serial
        '';
      };
      timeout = 10;
    };

    disko.devices.disk = {
      sda = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/";
        };
      };
      sdb = {
        device = "/dev/sdb";
        type = "disk";
        content = {
          type = "swap";
          randomEncryption = true;
          resumeDevice = true; # resume from hiberation from this device
        };
      };
    };

    # Packages that Linode use for support
    environment.systemPackages = [
      pkgs.inetutils
      pkgs.mtr
      pkgs.sysstat
    ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp0s5.useDHCP = lib.mkDefault true;

    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
