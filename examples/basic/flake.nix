{
  description = "A simple Linode server using levain";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  inputs.levain.url = "github:ciarandg/levain";
  inputs.levain.inputs.nixpkgs.follows = "nixpkgs";

  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, levain, disko }: {
    nixosConfigurations.example = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos-config.nix
        levain.nixosModules.levain
        disko.nixosModules.disko
      ];
    };
  };
}
