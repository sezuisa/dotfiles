{ lib, ... }:
{
  services.fprintd.enable = true;

  security.pam.services = {
    swaylock.fprintAuth = false;
    login.fprintAuth = lib.mkForce true;
    sudo.fprintAuth = true;
  };
}
