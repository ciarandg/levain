{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {...}: {
    nixosModules = {
      hardware-linode = import ./nix/hardware/linode;
      hardware-digitalocean-droplet = import ./nix/hardware/digitalocean;
    };
  };
}
