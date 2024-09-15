{ config, pkgs, pkgs-unstable, lib, inputs, ... }:
{

  gtk = {
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Ice";

    theme.name = "catppuccin-mocha-peach-standard+black";
    theme.package = pkgs.catppuccin-gtk.override {
      accents = [ "peach" ];
      size = "standard";
      tweaks = [ "black" ];
      variant = "mocha";
    };

    gtk2.extraConfig = "gtk-application-prefer-dark-theme = 1";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  xdg.dataFile."config-assets/nixos.jpg".source = ../assets/nixos.jpg;
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 60;
      inside-color = "000000";
      key-hl-color = "87c1cf";
      ring-color = "6081ac";
      show-failed-attempts = false;
      image = "${config.home.homeDirectory}/.local/share/config-assets/nixos.jpg";
    };
  };

  wayland.windowManager.hyprland =
    let
      # to get the hash when adding a new wallpaper, just use 'sha256="";', do a rebuild an use the hash from the error message
      wallpaper = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/sezuisa/wallpaper-vault/main/abstract/wallpaper-gold.jpg";
        sha256 = "09j49kpfykx6a7c7xcdrisq9k2bvgblzxlk4gaqrdwn9rhm08w9n";
      };
      submaps = {
        "SESSION" = {
          modifier = "$secMod";
          key = "L";
          bindings = [
            { key = "L"; command = "exec"; params = "hyprctl dispatch submap reset && ${pkgs.swaylock}/bin/swaylock"; description = "ock"; }
            { key = "S"; command = "exec"; params = "hyprctl dispatch submap reset && systemctl suspend"; description = "uspend"; }
            { key = "P"; command = "exec"; params = "hyprctl dispatch submap reset && systemctl poweroff"; description = "oweroff"; }
            { key = "R"; command = "exec"; params = "hyprctl dispatch submap reset && systemctl reboot"; description = "eboot"; }
          ];
        };
        "RESIZE" = {
          modifier = "$secMod";
          key = "R";
          bindings = [
            { key = "H"; command = "resizeactive"; params = "-10 0"; description = "left"; repeatable = true; }
            { key = "L"; command = "resizeactive"; params = "10 0"; description = "right"; repeatable = true; }
            { key = "K"; command = "resizeactive"; params = "0 -10"; description = "up"; repeatable = true; }
            { key = "J"; command = "resizeactive"; params = "0 10"; description = "down"; repeatable = true; }
          ];
        };
        "MOVE" = {
          modifier = "$secMod";
          key = "M";
          bindings = [
            { key = "H"; command = "moveactive"; params = "-40 0"; description = "left"; repeatable = true; }
            { key = "L"; command = "moveactive"; params = "40 0"; description = "right"; repeatable = true; }
            { key = "K"; command = "moveactive"; params = "0 -40"; description = "up"; repeatable = true; }
            { key = "J"; command = "moveactive"; params = "0 40"; description = "down"; repeatable = true; }
          ];
        };
        "SETTINGS" = {
          modifier = "$secMod";
          key = "S";
          bindings = [
            { key = "N"; command = "exec"; params = "hyprctl dispatch submap reset && ${pkgs-unstable.networkmanager_dmenu}/bin/networkmanager_dmenu"; description = "etwork"; }
            { key = "B"; command = "exec"; params = "hyprctl dispatch submap reset && kitty --detach -T bluetuith ${pkgs.zsh}/bin/zsh -c ${pkgs.bluetuith}/bin/bluetuith"; description = "luetooth"; }
            { key = "S"; command = "exec"; params = "hyprctl dispatch submap reset && ${pkgs.pavucontrol}/bin/pavucontrol"; description = "ound"; }
          ];
        };
        "DISPLAY" = {
          modifier = "$secMod";
          key = "D";
          bindings = [
            { key = "M"; command = "exec"; params = ''hyprctl dispatch submap reset && hyprctl keyword monitor ",highres,auto,1,mirror,eDP-1"''; description = "irror"; }
            { key = "E"; command = "exec"; params = ''hyprctl dispatch submap reset && hyprctl keyword monitor ",highres,auto,1"''; description = "xtend"; }
            { key = "S"; command = "exec"; params = ''hyprctl dispatch submap reset && hyprctl keyword monitor "eDP-1, disable"''; description = "ingle"; }
            { key = "R"; command = "exec"; params = ''hyprctl dispatch submap reset && systemctl --user restart waybar.service''; description = "eload"; }
          ];
        };
      };
      schlago-update-waybar = pkgs.writeShellScript "schlago-update.sh" ''
        sleep .1
        pkill -RTMIN+4 waybar 
      '';
    in
    {
      enable = true;
      settings = {
        "$mainMod" = "SUPER";
        "$secMod" = "ALT";
        input = {
          kb_layout = "de,us";
          kb_options = "grp:alt_shift_toggle";
          touchpad = {
            natural_scroll = true;
          };
        };
        general = {
          gaps_in = 3;
          gaps_out = 10;
          border_size = 1;
          "col.active_border" = "0xeed18c47";
          "col.inactive_border" = "0xaa96724e";
          resize_on_border = true;
        };
        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            noise = 0.1;
          };
        };
        gestures = {
          workspace_swipe = true;
        };
        misc = {
          disable_hyprland_logo = true;
          force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
        };
        # highres and scaling 1 is important to fix wayland scaling issues
        monitor = ",highres,auto,1";
      };
      extraConfig = ''
        # focus
        bind = CTRL,right,movefocus,r
        bind = CTRL,left,movefocus,l
        bind = CTRL,up,movefocus,u
        bind = CTRL,down,movefocus,d

        # jump
        bind = $mainMod,1,workspace,1
        bind = $mainMod,2,workspace,2
        bind = $mainMod,3,workspace,3
        bind = $mainMod,4,workspace,4
        bind = $mainMod,5,workspace,5
        bind = $mainMod,L,workspace,+1
        bind = $mainMod,H,workspace,-1

        # move
        bind = $mainMod SHIFT,1,movetoworkspace,1
        bind = $mainMod SHIFT,2,movetoworkspace,2
        bind = $mainMod SHIFT,3,movetoworkspace,3
        bind = $mainMod SHIFT,4,movetoworkspace,4
        bind = $mainMod SHIFT,5,movetoworkspace,5
        bind = $mainMod SHIFT,L,movetoworkspace,+1
        bind = $mainMod SHIFT,H,movetoworkspace,-1
        bind = $mainMod,Q,killactive,

        ${lib.strings.concatStringsSep "\n\n" (lib.attrsets.mapAttrsToList
        (name: value: let
        nameWithDesc = "${name} ${lib.strings.concatMapStringsSep " "
        (binding: "(${binding.key})${binding.description}")
        value.bindings}";
        in ''
        bind = ${value.modifier},${value.key},submap,${nameWithDesc}
        submap = ${nameWithDesc}
        ${lib.strings.concatMapStringsSep "\n" (binding:
        lib.strings.concatStringsSep "," [
        "bind${if binding.repeatable or false then "e" else ""} = "
        binding.key
        binding.command
        binding.params
        ]) value.bindings}
        bind = ,escape,submap,reset
        submap = reset
        ''
        ) submaps)}

        exec-once = ${pkgs.swaybg}/bin/swaybg --image ${wallpaper}

        # lock screen on lid close
        bindl = ,switch:Lid Switch,exec,${pkgs.swaylock}/bin/swaylock

        # launch
        bind = $mainMod,SPACE,exec,rofi -show drun -show-icons
        layerrule = dimaround,rofi
        layerrule = animation popin 80%,rofi
        layerrule = blur,rofi
        layerrule = ignorealpha 0.2,rofi

        # notifications
        layerrule = blur,^(swaync-control-center)$
        layerrule = ignorealpha 0.2,^(swaync-control-center)$
        layerrule = animation slide right,^(swaync-control-center)$
        layerrule = blur,^(swaync-notification-window)$
        layerrule = ignorealpha 0.2,^(swaync-notification-window)$
        layerrule = animation slide top,^(swaync-notification-window)$

        # waybar background blur
        layerrule = blur,^(waybar)$
        layerrule = ignorealpha 0.2,^(waybar)$

        # terminal
        bind = $mainMod,Return,exec,kitty

        # brightness
        bind = ,XF86MonBrightnessUp,exec,${pkgs.brightnessctl}/bin/brightnessctl set +10%
        bind = ,XF86MonBrightnessDown,exec,${pkgs.brightnessctl}/bin/brightnessctl set 10%-

        # volume
        bind = ,XF86AudioMute,exec,${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle
        bind = ,XF86AudioMicMute,exec,${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle
        bind = ,XF86AudioRaiseVolume,exec,${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%
        bind = ,XF86AudioLowerVolume,exec,${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%
        bind = SHIFT,XF86AudioRaiseVolume,exec,${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%
        bind = SHIFT,XF86AudioLowerVolume,exec,${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%

        # media
        bind = ,XF86AudioPlay,exec,${pkgs.playerctl}/bin/playerctl play-pause
        bind = ,XF86AudioNext,exec,${pkgs.playerctl}/bin/playerctl next
        bind = ,XF86AudioPrev,exec,${pkgs.playerctl}/bin/playerctl previous

        # screenshot
        bind = CTRL SHIFT,s,exec,${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png

        # file manager
        bind = $mainMod,F,exec,kitty lf

        # control center
        bind = $secMod,C,exec,swaync-client -t -sw

        # floating windows
        bind = $mainMod, V, togglefloating
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, Control_L, movewindow
        bindm = $mainMod, mouse:273, resizewindow
        bindm = $mainMod, ALT_L, resizewindow

        # schlag-o-meter
        bind = $mainMod,U,exec,${schlago-update-waybar}
        bind = $mainMod,plus,exec,${pkgs.openssh}/bin/ssh schlago-pi "incr 5"; ${schlago-update-waybar}
        bind = $mainMod SHIFT,minus,exec,${pkgs.openssh}/bin/ssh schlago-pi "set 0"; ${schlago-update-waybar}

        windowrule = float,title:^(nmtui|bluetuith|Volume Control|quicknote|Calendar)$
        windowrule = center,title:^(nmtui|bluetuith|Volume Control|quicknote|Calendar)$
        windowrule = size 900 500,title:^(nmtui|bluetuith|Volume Control|quicknote)$
        windowrule = size 1200 900,title:^(Calendar)$
      '';
    };
}
