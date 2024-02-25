{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  inputs.flake-parts.url = "github:hercules-ci/flake-parts";

  outputs = {flake-parts, ...} @ inputs: flake-parts.lib.mkFlake {inherit inputs;} {
    flake.nixosModules.levain = import ./nix;
  };
}
