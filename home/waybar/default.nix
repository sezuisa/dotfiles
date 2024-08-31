{ pkgs, pkgs-unstable, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      foo = {
        layer = "top";
        modules-center = [ "hyprland/workspaces" "network" "pulseaudio" "battery" "clock" ];
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
        };
        clock = {
          on-double-click = "gnome-calendar";
          format = "{:%A | %F | %H:%M}";
          tooltip = false;
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "BAT: {capacity}%";
          format-charging = "BAT: {capacity}%";
          format-plugged = "BAT: {capacity}%";
          format-alt = "BAT: {time}";
          format-full = "BAT: {capacity}%";
        };
        network = {
          on-double-click = "${pkgs-unstable.networkmanager_dmenu}/bin/networkmanager_dmenu";
          format = "NET";
          format-wifi = "NET: {essid}";
          format-ethernet = "NET: WIRED";
          format-disconnected = "Net Disconnected";
          tooltip = false;
        };
        pulseaudio = {
          on-double-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          format = "{icon}: {volume}%";
          format-muted = "VOL: Muted";
          format-icons = {
            headphone = "H";
            hands-free = "HF";
            headset = "HS";
            phone = "PH";
            portable = "P";
            car = "C";
            default = [ "VOL" ];
          };
          tooltip = false;
        };
      };
    };
    style = ./bar.css;
  };
}
