{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 20; # Limit the number of generations to keep
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
