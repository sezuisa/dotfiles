{ config, ... }:
{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      extra-platforms = config.boot.binfmt.emulatedSystems;
    };

    # Perform garbage collection weekly
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # Optimize store automatically
    optimise.automatic = true;
  };
}
