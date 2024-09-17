{ pkgs, ... }:
{
  services = {
    fwupd.enable = true;
    printing.enable = true;
    dbus.enable = true;
  };
}
