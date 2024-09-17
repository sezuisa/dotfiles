{ pkgs, config, inputs, ... }:
{
  imports = [
    ./nix.nix
    ./boot.nix
    ./user.nix
    ./locale.nix
    ./services.nix
    ./sound.nix
    ./virtualisation.nix
    ./kdeconnect.nix
    ./hyprland.nix
    ./network.nix
    ./fingerprint.nix
    ./tailscale.nix
    ./mounts.nix
    ./ssh.nix
    ./thunar.nix
    ./bluetooth.nix
  ];

  environment.systemPackages = with pkgs; [
    wget
    vim
    curl
    inputs.agenix.packages.x86_64-linux.default
    xarchiver
    davfs2
  ];

  system.stateVersion = "23.11";
}
