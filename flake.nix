{
  description = "The Irrenflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
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

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";

      overlays = [
        (import ./overlays/schlago.nix)
      ];

      # Convert a flake into a package set (allow unfree packages by default, and
      # accept a list of overlay functions to apply).
      unflake = { flake, overlays ? [ ] }: import flake {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays;
      };

      # Arrange to pass the instantiated package sets into every module (via the
      # 'specialArgs' value).
      nixpkgs' = unflake { flake = nixpkgs; overlays = overlays; };
      specialArgs = {
        inherit inputs;
        nixpkgs = nixpkgs';
        pkgs-unstable = unflake { flake = nixpkgs-unstable; };
        pkgs = nixpkgs';
      };
      treefmtEval = inputs.treefmt-nix.lib.evalModule specialArgs.pkgs ./treefmt.nix;
    in
    {
      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatter = treefmtEval.config.build.check self;

      nixosConfigurations = {
        irrenhost = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
          modules = [
            ./configuration.nix
            ./hardware/hardware-configuration.nix
            ./modules
            inputs.agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              #home-manager.useUserPackages = true;
              home-manager.users.sez = {
                imports = [
                  ./home/home.nix
                ];
              };
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };
    };
}
