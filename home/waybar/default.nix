{ config, pkgs, pkgs-unstable, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      foo = {
        layer = "top";
        modules-center = [ "hyprland/workspaces" "network" "pulseaudio" "battery" "clock" "custom/schlag-o-meter" ];
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
        "custom/schlag-o-meter" = {
          interval = 30;
          tooltip-format = "Schlag-O-Meter";
          format = " {}";
          signal = 4;
          return-type = "json";
          exec = pkgs.writeShellScript "fetch-data" ''
            # fetch current counter value from server
            count=''$(${pkgs.openssh}/bin/ssh schlago "get")

            if [[ ''$count -gt 99 ]] then
              ${pkgs.libnotify}/bin/notify-send -u critical "ATTENTION" "Schlag-O-Meter threshold has been reached";
              echo "{\"class\": \"critical\", \"text\": \"''$count\"}";
            else
              echo "{\"class\": \"\", \"text\": \"''$count\"}";
            fi
          '';
        };
      };
    };
    style = ./bar.css;
  };
}
