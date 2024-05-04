{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      # shortcuts
      ll = "ls -lisa";
      n = "neofetch";

      # nixos update commands
      update = "sudo nixos-rebuild switch --flake .#";
      update-boot = "sudo nixos-rebuild boot --flake .#";
      update-test = "sudo nixos-rebuild test --flake .#";

      # other stuff
      hibernate = "systemctl hibernate";
    };
    enableCompletion = true;

    initExtra = ''
      neofetch
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "battery"
      ];
      theme = "agnoster";
    };
  };
}
