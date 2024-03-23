{ config, pkgs, foxtheme, ... }:

{
  home.packages = with pkgs; [
    # gnome
    gnomeExtensions.blur-my-shell

    # development
    python3
    neovim
    arduino
    nodejs_21

    # utilities
    yubioath-flutter
    podman-compose
    libsForQt5.kdeconnect-kde

    # apps
    signal-desktop
    cider
    gimp
    element-desktop
    keepassxc
    thunderbird
    darktable
  ];

  home.username = "sez";
  home.homeDirectory = "/home/sez";

  programs.home-manager.enable = true;

  programs.bash.enable = true;

  imports = [
    ./vscodium.nix
    ./git.nix
    ./firefox.nix
    ./gpg.nix
    ./protonmail.nix

    ./wallpaper.nix

    ./default-applications.nix
  ];

  home.stateVersion = "23.11";
}
