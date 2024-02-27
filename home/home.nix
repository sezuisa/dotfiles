{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # development
    python3
    neovim
    arduino

    # utilities
    yubioath-flutter
    podman-compose

    # apps
    firefox
    signal-desktop
    cider
    gimp
  ];

  home.username = "sez";
  home.homeDirectory = "/home/sez";

  programs.home-manager.enable = true;

  programs.bash.enable = true;

  imports = [
    ./vscodium.nix
    ./git.nix

    ./wallpaper.nix

    ./default-applications.nix
  ];

  home.stateVersion = "23.11";
}
