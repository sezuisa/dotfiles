{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  services = {
    libinput.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "";
      };
      excludePackages = [ pkgs.xterm ];
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
}
