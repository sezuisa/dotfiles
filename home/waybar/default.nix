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
          format = " {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = " {time}";
          format-full = " {capacity}%";
        };
        network = {
          on-double-click = "${pkgs-unstable.networkmanager_dmenu}/bin/networkmanager_dmenu";
          format = "";
          format-wifi = " {essid}";
          format-ethernet = " Wired";
          format-disconnected = "Net Disconnected";
          tooltip = false;
        };
        pulseaudio = {
          on-double-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            headphone = "";
            headset = "";
            phone = "";
            default = [ "" ];
          };
          tooltip = false;
        };
      };
    };
    style = ./bar.css;
  };
}
