let
  # to get the hash when adding a new wallpaper, just use 'sha256="";', do a rebuild an use the hash from the error message
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sezuisa/wallpaper-vault/main/abstract/wallpaper-gold.jpg";
    sha256 = "09j49kpfykx6a7c7xcdrisq9k2bvgblzxlk4gaqrdwn9rhm08w9n";
  };
in
{
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
}
