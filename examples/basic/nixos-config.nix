{
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  config = {
    levain = {
      hardware.linode.enable = true;
      user.authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPiQGm1ZXWXa6mIwMHqlNaMiSMfK0UjVc8LZ7VhjmM admin@pc"
      ];
    };

    system.stateVersion = "23.11";

    networking.firewall.enable = false;
    networking.useDHCP = true;

    security.sudo.wheelNeedsPassword = false;

    services.nginx.enable = true;

    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
