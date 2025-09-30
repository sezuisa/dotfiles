{ inputs, ... }:

{
  # home.file.".mozilla/firefox/sez/chrome".source = inputs.foxtheme;
  # programs.firefox = {
  #   enable = true;
  #   profiles.sez = {
  #     settings = {
  #       "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  #       "browser.tabs.inTitlebar" = 1;
  #     };
  #   };
  # };
  textfox = {
    enable = true;
    profile = "sezuisa";
    config = {
      background = {
        color = "#2f231f";
      };
      border = {
        color = "#e7c59e";
        width = "2px";
        transition = "1.0s ease";
        radius = "5px";
      };
      displayHorizontalTabs = false;
      displayWindowControls = false;
      displayNavButtons = true;
      displayUrlbarIcons = true;
      displaySidebarTools = true;
      displayTitles = true;
      font = {
        family = "JetBrains Mono";
        size = "16px";
        accent = "#d18c47";
      };
    };
  };
}
