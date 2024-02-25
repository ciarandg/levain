# NOTE: I have not yet been able to get networking to work on DigitalOcean.
# It seems that a bunch of NixOS configuration needs to be generated dynamically
# for a given host.
# Sources:
#   - https://justinas.org/nixos-in-the-cloud-step-by-step-part-1
#   - https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/digital-ocean-config.nix
#   - https://github.com/elitak/nixos-infect

{config, lib, ...}: let
  cfg = config.levain.hardware.digitalocean;
in {
  options = {
    levain.hardware.digitalocean = {
      enable = lib.mkEnableOption {
        description = "Whether to enable DigitalOcean droplet hardware support";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      growPartition = true;
      kernelParams = [ "console=ttyS0" "panic=1" "boot.panic_on_fail" ];
      initrd.kernelModules = [ "virtio_scsi" ];
      kernelModules = [ "virtio_pci" "virtio_net" ];

      loader = {
        timeout = 0;
        grub = {
          efiSupport = true;
          efiInstallAsRemovable = true;
        };
      };
    };

    disko.devices = {
      disk.disk1 = {
        device = lib.mkDefault "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };
            esp = {
              name = "ESP";
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              name = "root";
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
      lvm_vg = {
        pool = {
          type = "lvm_vg";
          lvs = {
            root = {
              size = "100%FREE";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountOptions = [
                  "defaults"
                ];
              };
            };
          };
        };
      };
    };
  };
}
