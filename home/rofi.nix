{ pkgs, config, ... }:
{
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
                bg0 = mkLiteral "rgba(99, 71, 60, 50%)";
                bg1 = mkLiteral "rgba(126, 126, 126, 80%)";
                bg2 = mkLiteral "rgba (209, 140, 71, 100%)";

                fg0 = mkLiteral "rgba(222, 222, 222, 100%)";
                fg1 = mkLiteral "rgba(255, 255, 255, 100%)";
                fg2 = mkLiteral "rgba (209, 140, 71, 100%)";

                background-color = mkLiteral "transparent";
                text-color = mkLiteral "@fg0";

                margin = 0;
                padding = 0;
                spacing = 0;
            };

            "window" = {
                background-color = mkLiteral "@bg0";

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
                filename = "search";
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
                placeholder-color = mkLiteral "@fg2";
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
                text-color = mkLiteral "@bg2";
            };

            "element selected normal" = {
                background-color = mkLiteral "@bg2";
                text-color = mkLiteral "@fg1";
            };
            
            "element selected active" = {
                background-color = mkLiteral "@bg2";
                text-color = mkLiteral "@fg1";
            };
        };
    };
}