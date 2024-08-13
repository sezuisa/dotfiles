{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      sezbar = {
        layer = "top";
        modules-center = [ "hyprland/workspaces" "network" "pulseaudio" "battery" "clock" ];
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
        };
        clock = {
          format = "{:%A | %F | %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
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
          format = "NET";
          format-wifi = "NET: {essid}";
          format-ethernet = "NET: WIRED";
          format-disconnected = "Net Disconnected";
          tooltip-format-wifi = "Signal Strenght: {signalStrength}% | Down Speed: {bandwidthDownBits}, Up Speed: {bandwidthUpBits}";
        };
        pulseaudio = {
          on-click = "pactl set-sink-mute 45 toggle";
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
        };
      };
    };
    style = ./bar.css;
  };
}
