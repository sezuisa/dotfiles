{ pkgs, lib, inputs, ... }:
{

  gtk = {
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Ice";

    theme.package = pkgs.nightfox-gtk-theme;
    theme.name = "Nightfox-Dusk-BL";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

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
      image = "/home/sez/nixos/assets/nixos.jpg";
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
        "FOCUS" = {
          modifier = "$secMod";
          key = "B";
          bindings = [
            { key = "H"; command = "movefocus"; params = "l"; description = "left"; }
            { key = "L"; command = "movefocus"; params = "r"; description = "right"; }
            { key = "K"; command = "movefocus"; params = "u"; description = "up"; }
            { key = "J"; command = "movefocus"; params = "d"; description = "down"; }
          ];
        };
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
        "SETTINGS" = {
          modifier = "$secMod";
          key = "S";
          bindings = [
            { key = "N"; command = "exec"; params = "hyprctl dispatch submap reset && kitty --detach -T nmtui ${pkgs.zsh}/bin/zsh -c nmtui"; description = "etwork"; }
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
    in
    {
      enable = true;
      settings = {
        "$mainMod" = "SUPER";
        "$secMod" = "ALT";
        input = {
          kb_layout = "us,de";
          kb_options = "grp:alt_shift_toggle";
          touchpad = {
            natural_scroll = true;
          };
        };
        general = {
          "gaps_in" = 3;
          "gaps_out" = 10;
          "border_size" = 1;
          "col.active_border" = "0xeed18c47";
          "col.inactive_border" = "0xaa96724e";
        };
        decoration = {
          rounding = 10;
        };
        misc = {
          disable_hyprland_logo = true;
          "force_default_wallpaper" = 0; # Set to 0 to disable the anime mascot wallpapers
        };
        # highres and scaling 1 is important to fix wayland scaling issues
        monitor = ",highres,auto,1";
      };
      extraConfig = ''
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

        # launch
        bind = $mainMod,SPACE,exec,${pkgs.wofi}/bin/wofi --show=drun
        # terminal
        bind = $mainMod,Return,exec,kitty
        bind = $secMod,SPACE,exec,hyprctl devices | ${pkgs.gnugrep}/bin/grep 'keyboard' | tr -d '\t' | xargs -I KEYBOARD hyprctl switchxkblayout KEYBOARD next
        # brightness
        bind = $secMod,up,exec,${pkgs.brightnessctl}/bin/brightnessctl set +10%
        bind = $secMod,down,exec,${pkgs.brightnessctl}/bin/brightnessctl set 10%-
        # screenshot
        bind = CTRL SHIFT,s,exec,${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png
        #file manager
        bind = $mainMod,F,exec,kitty lf

        # floating settings windows
        windowrule = float,title:^(nmtui|bluetuith|Volume Control|quicknote)$
        windowrule = center,title:^(nmtui|bluetuith|Volume Control|quicknote)$
        windowrule = size 900 500,title:^(nmtui|bluetuith|Volume Control|quicknote)$
      '';
    };
}
