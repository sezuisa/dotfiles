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
      bookmarks = [
        {
          name = "Bookmarks Toolbar";
          toolbar = true;
          bookmarks = [
            {
              name = "NixOS";
              bookmarks = [
                { name = "NixOS Search Packages"; url = "https://search.nixos.org/packages"; }
                { name = "NixOS Home Manager Option Search"; url = "https://mipmip.github.io/home-manager-option-search"; }
                { name = "NixOS User Repositories Search"; url = "http://nur.nix-community.org/"; }
                { name = "NixOS & Flakes Handbook"; url = "https://nixos-and-flakes.thiscute.world/"; }
              ];
            }
          ];
        }
      ];
    };
  };
}
