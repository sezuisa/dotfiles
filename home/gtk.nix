{ pkgs, config, ... }:
{
  gtk = {
    enable = true;
    cursorTheme.package = pkgs.whitesur-cursors;
    cursorTheme.name = "WhiteSur-cursors";

    theme.name = "catppuccin-mocha-peach-standard+black";
    theme.package = pkgs.catppuccin-gtk.override {
      accents = [ "peach" ];
      size = "standard";
      tweaks = [ "black" ];
      variant = "mocha";
    };

    gtk2.extraConfig = "gtk-application-prefer-dark-theme = 1";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
