{ inputs, ... }:

{
  home.file.".mozilla/firefox/sez/chrome".source = inputs.foxtheme;
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
