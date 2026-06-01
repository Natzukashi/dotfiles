{
  description = "tsuwabuki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nur,
    }:
    {
      nixosConfigurations.tsuwabuki = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [ nur.overlays.default ];
            }
          )
          ./configuration.nix
        ];
      };
    };
}
