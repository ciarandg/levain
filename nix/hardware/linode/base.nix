{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = {
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
