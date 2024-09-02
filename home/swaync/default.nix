{ pkgs, ... }:

{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      cssPriority = "user";
      layer = "overlay";

      control-center-layer = "overlay";
      control-center-width = 400;
      control-center-margin-top = 0;
      control-center-margin-bottom = 0;
      control-center-margin-right = 0;
      control-center-margin-left = 0;

      notification-2fa-action = true;
      notification-inline-replies = false;

      notification-window-width = 400;
      notification-icon-size = 48;
      notification-body-image-height = 160;
      notification-body-image-width = 200;

      timeout = 4;
      timeout-low = 2;
      timeout-critical = 6;

      fit-to-screen = true;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      script-fail-notify = true;
      hide-on-clear = true;
      layer-shell = true;

      scripts = {
        example-script = {
          exec = "echo 'Do something...'";
          urgency = "Normal";
        };
      };

      notification-visibility = {
        example-name = {
          state = "muted";
          urgency = "low";
          app-name = "Spotify";
        };
      };

      widgets = [
        "label"
        "buttons-grid"
        "mpris"
        "volume"
        "backlight"
        "title"
        "dnd"
        "notifications"
      ];

      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "󰎟";
        };
        dnd = {
          text = "Do not disturb";
        };
        label = {
          max-lines = 1;
          text = " ";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
        volume = {
          label = "";
          expand-button-label = "";
          collapse-button-label = "";
          show-per-app = true;
          show-per-app-icon = false;
          show-per-app-label = true;
        };
        backlight = {
          label = "";
          device = "amdgpu_bl1";
        };
        buttons-grid = {
          actions = [
            {
              label = "";
              command = "systemctl poweroff";
            }
            {
              label = "󰜉";
              command = "systemctl reboot";
            }
            {
              label = "󰌾";
              command = "${pkgs.swaylock}/bin/swaylock";
            }
          ];
        };
      };
    };
    style = ./swaync_style.css;
  };
}
