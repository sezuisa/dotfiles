let
  # to get the hash when adding a new wallpaper, just use 'sha256="";', do a rebuild an use the hash from the error message
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sezuisa/wallpaper-vault/main/star-trek/wallpaper-enterprise-cropped.jpg";
    sha256 = "0jipiap36xdw8x30p8fpfrzq3y8prb260r73za690ky1hplixfli";
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
