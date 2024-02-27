{ config, pkgs, ... }:

let
  # to get the hash when adding a new wallpaper, just use 'sha256="";', do a rebuild an use the hash from the error message
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sezuisa/wallpaper-vault/main/star-trek/wallpaper-enterprise-cropped.jpg";
    sha256 = "0jipiap36xdw8x30p8fpfrzq3y8prb260r73za690ky1hplixfli";
  };
in

{
  home.packages = with pkgs; [
    # development
    git
    python3
    neovim
    vscode
    arduino

    # utilities
    docker
    yubioath-flutter

    # apps
    firefox
    signal-desktop
    cider
    gimp

  ];

  home.username = "sez";
  home.homeDirectory = "/home/sez";

  programs.home-manager.enable = true;

  #manual.manpages.enable = false;

  programs.bash.enable = true;
  programs.git = {
    enable = true;
    userName = "Sarah Hägele";
    userEmail = "sarah.haegele01@gmail.com";
  };

  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file://${wallpaper}";
      picture-uri-dark = "file://${wallpaper}";
      primary-color = "#3366ff";
      secondary-color = "#000000";
    };
  };

  home.stateVersion = "23.11";
}
