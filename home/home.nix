{ config, pkgs, pkgs-unstable, foxtheme, ... }:

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
    neofetch

    # apps
    signal-desktop
    cider
    gimp
    element-desktop
    keepassxc
    darktable
    inkscape
    nuclear
    bruno

    # unstable
    pkgs-unstable.protonmail-desktop
  ];

  home.username = "sez";
  home.homeDirectory = "/home/sez";

  programs.home-manager.enable = true;

  programs.bash.enable = true;

  imports = [
    ./zsh.nix
    ./kitty.nix
    ./vscodium.nix
    ./git.nix
    ./firefox.nix
    ./gpg.nix

    ./wallpaper.nix

    ./default-applications.nix
  ];

  home.stateVersion = "23.11";
}
