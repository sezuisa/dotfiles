{ config, pkgs, pkgs-unstable, inputs, ... }:

{
  home.packages = with pkgs; [
    # gnome
    evince # gnome pdf reader
    eog # gnome image viewer
    gnome-calendar

    # development
    python3
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
    networkmanagerapplet
    libnotify
    bluetuith

    # apps
    signal-desktop
    cider
    gimp
    element-desktop
    keepassxc
    darktable
    inkscape
    bruno
    prusa-slicer
    protonmail-desktop

    # unstable
    pkgs-unstable.networkmanager_dmenu

    # custom derivations/overlays
    # schlago
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
    ./swaylock.nix
    ./rofi.nix
    ./lf.nix
    ./nmdm-config.nix
    ./swaync
    ./ssh.nix
    ./gtk.nix
    ./neovim.nix

    ./default-applications.nix
  ];

  home.stateVersion = "23.11";
}
