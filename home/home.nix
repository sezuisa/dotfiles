{ pkgs, foxtheme, ... }:

{
  home.packages = with pkgs; [
    # gnome
    gnomeExtensions.blur-my-shell

    # development
    python3
    neovim
    arduino

    # utilities
    yubioath-flutter
    podman-compose

    # apps
    signal-desktop
    cider
    gimp
    element-desktop
    keepassxc
  ];

  home.username = "sez";
  home.homeDirectory = "/home/sez";

  programs.home-manager.enable = true;

  programs.bash.enable = true;

  imports = [
    ./vscodium.nix
    ./git.nix
    ./firefox.nix

    ./wallpaper.nix

    ./default-applications.nix
  ];

  home.stateVersion = "23.11";
}
