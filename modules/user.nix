{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.users.sez = {
    isNormalUser = true;
    description = "Sarah Hägele";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];
    shell = pkgs.zsh;
  };
}
