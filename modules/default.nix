{ pkgs, inputs, ... }:
{
  imports = [
    ./gc.nix
    ./virtualisation.nix
    ./kdeconnect.nix
    ./hyprland.nix
    ./network.nix
    ./fingerprint.nix
    ./tailscale.nix
    ./mounts.nix
    ./ssh.nix
  ];

  environment.systemPackages = with pkgs; [
    wget
    vim
    curl
    inputs.agenix.packages.x86_64-linux.default
  ];
}
