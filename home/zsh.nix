{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      # shortcuts
      ll = "ls -lisa";
      ff = "fastfetch";

      # nixos update commands
      update = "git add -N; sudo nixos-rebuild switch --flake .#";
      update-boot = "git add -N; sudo nixos-rebuild boot --flake .#";
      update-test = "git add -N; sudo nixos-rebuild test --flake .#";

      # other stuff
      hibernate = "systemctl hibernate";
    };
    enableCompletion = true;

    initExtra = ''
      fastfetch
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
