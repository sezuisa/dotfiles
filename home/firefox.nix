{ foxtheme, ... }:

{
  home.file.".mozilla/firefox/sez/chrome".source = foxtheme;
  programs.firefox = {
    enable = true;
    profiles.sez = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.inTitlebar" = 1;
      };
    };
  };
}
