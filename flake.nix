{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
    irrenhost = lib.nixosSystem {
        inherit system pkgs;
        modules = [
          ./configuration.nix
	        ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            #home-manager.useUserPackages = true;
            home-manager.users.sez = import ./home.nix;
          }
        ];
      };
    };
  };
}
