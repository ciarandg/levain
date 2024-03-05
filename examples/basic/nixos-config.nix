{
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./services.nix
  ];

  config = {
    levain = {
      hardware.linode.enable = true;
      user.authorizedKeys = [
        # Put the contents of your public key here!
        # NOTE: Should be identical to Terraform var.ssh_public_key
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHw1Sn/UDAG1IoXMUiN+kuM9aiSub+t8kE6yUXlp76nY admin@pc"
      ];
    };

    system.stateVersion = "23.11";

    networking.firewall.enable = false;
    networking.useDHCP = true;

    security.sudo.wheelNeedsPassword = false;

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
