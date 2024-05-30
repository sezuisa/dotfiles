{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  # hyprland complains now that wlr and hyprland portal are active at the same time
  # xdg.portal.wlr.enable = true;
  security = {
    rtkit.enable = true;
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "de";
      xkbVariant = "";
      excludePackages = [ pkgs.xterm ];
      libinput.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    gnome = {
      #sushi.enable = true;
      gnome-keyring.enable = true;
    };
  };

}
