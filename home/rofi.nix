{ pkgs, config, ... }:
{
  xdg.dataFile."config-assets/search.svg".source = ../assets/search.svg;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "JetBrains Mono 16";
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          base-05 = mkLiteral "rgba(99, 71, 60, 50%)";
          bg1 = mkLiteral "rgba(126, 126, 126, 80%)";
          mango = mkLiteral "rgba (209, 140, 71, 100%)";

          text-08 = mkLiteral "rgba(255, 255, 255, 80%)";
          text = mkLiteral "rgba(255, 255, 255, 100%)";

          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@text-08";

          margin = 0;
          padding = 0;
          spacing = 0;
        };

        "window" = {
          transparency = "real";
          background-color = mkLiteral "@base-05";

          location = mkLiteral "center";
          width = 640;
          border-radius = 8;
        };

        "inputbar" = {
          font = "JetBrains Mono 20";
          padding = mkLiteral "12px";
          spacing = mkLiteral "12px";
          children = map mkLiteral [ "icon-search" "entry" ];
        };

        "icon-search" = {
          expand = mkLiteral "false";
          filename = "${config.home.homeDirectory}/.local/share/config-assets/search.svg";
          size = mkLiteral "28px";
          vertical-align = mkLiteral "0.5";
        };

        "element-icon" = {
          vertical-align = mkLiteral "0.5";
          size = mkLiteral "1em";
        };

        "element-text" = {
          vertical-align = mkLiteral "0.5";
          text-color = mkLiteral "inherit";
        };

        "entry" = {
          font = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          placeholder = "Search";
          placeholder-color = mkLiteral "@mango";
        };

        "message" = {
          border = mkLiteral "2px 0 0";
          border-color = mkLiteral "@bg1";
          background-color = mkLiteral "@bg1";
        };

        "textbox" = {
          padding = mkLiteral "8px 24px";
        };

        "listview" = {
          lines = 10;
          columns = 1;

          fixed-height = mkLiteral "false";
          border = mkLiteral "1px 0 0";
          border-color = mkLiteral "@bg1";
        };

        "element" = {
          padding = mkLiteral "8px 16px";
          spacing = mkLiteral "16px";
          background-color = mkLiteral "transparent";
        };

        "element normal active" = {
          text-color = mkLiteral "@mango";
        };

        "element selected normal" = {
          background-color = mkLiteral "@mango";
          text-color = mkLiteral "@text";
        };

        "element selected active" = {
          background-color = mkLiteral "@mango";
          text-color = mkLiteral "@text";
        };
      };
  };
}
