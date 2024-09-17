{ config, ... }:
{
  xdg.dataFile."config-assets/nixos.jpg".source = ../assets/nixos.jpg;
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 60;
      inside-color = "000000";
      key-hl-color = "87c1cf";
      ring-color = "6081ac";
      show-failed-attempts = false;
      image = "${config.home.homeDirectory}/.local/share/config-assets/nixos.jpg";
    };
  };
}
