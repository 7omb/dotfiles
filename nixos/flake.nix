{
  description = "Intricate puzzle of packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      rocket = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/rocket/configuration.nix
          ./modules/common.nix
          ./modules/tom.nix
          ./modules/tomDesktop.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
