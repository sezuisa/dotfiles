{foxtheme, ...}:

{
  home.file.".mozilla/firefox/sez/chrome/blurredfox".source = foxtheme;

  programs.firefox = {
    enable = true;
    profiles.sez = {
      userChrome = ''
        @import url('blurredfox/userChrome.css');
      '';
      userContent = ''
        @import url('blurredfox/userContent.css');
      '';
      extraConfig = ''
        toolkit.legacyUserProfileCustomizations.stylesheets = true;
        layers.acceleration.force-enabled = true;
        gfx.webrender.all = true;
        gfx.webrender.enabled = true;
        layout.css.backdrop-filter.enabled = true;
        svg.context-properties.content.enabled = true;
      '';
    };
  };
}
