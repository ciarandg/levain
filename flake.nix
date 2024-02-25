{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {self, ...}: {
    nixosModules = {
      hardware-linode = import ./nix/hardware/linode.nix;
      hardware-digitalocean-droplet = import ./nix/hardware/digitalocean-droplet;
    };
  };
}
