{
  description = "The Irrenflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # formatter for *.nix files
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # custom firefox css
    foxtheme = {
      url = "github:sezuisa/whatthefox";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, treefmt-nix, foxtheme, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;

      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
    in
    {
      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatter = treefmtEval.config.build.check self;

      nixosConfigurations = {
        irrenhost = lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./configuration.nix
            ./hardware/hardware-configuration.nix
            ./modules
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              #home-manager.useUserPackages = true;
              home-manager.users.sez = import ./home/home.nix;
              home-manager.extraSpecialArgs = { inherit foxtheme; };
            }
          ];
        };
      };
    };
}
