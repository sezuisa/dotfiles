{ config, pkgs, pkgs-unstable, foxtheme, ... }:

{
  home.packages = with pkgs; [
    # gnome
    evince # gnome pdf reader
    gnome.eog # gnome image viewer

    # development
    python3
    neovim
    arduino
    nodejs_22

    # utilities
    yubioath-flutter
    podman-compose
    libsForQt5.kdeconnect-kde
    fastfetch
    wl-clipboard
    unzip
    pistol
    file

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
    protonmail-desktop
  ];

  home.username = "sez";
  home.homeDirectory = "/home/sez";

  programs.home-manager.enable = true;

  programs.bash.enable = true;

  imports = [
    ./clonerer.nix
    ./zsh.nix
    ./kitty.nix
    ./vscodium.nix
    ./git.nix
    ./firefox.nix

    ./waybar
    ./hyprland.nix
    ./rofi.nix
    ./lf.nix

    #./wallpaper.nix

    ./default-applications.nix
  ];

  home.stateVersion = "23.11";
}
