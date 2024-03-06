{ lib, pkgs, ... }:

{
  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 20;

  # Perform garbage collection weekly
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Optimize store automatically
  nix.optimise.automatic = true;
}
