{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "beardedtheme";
        publisher = "beardedbear";
        version = "9.1.4";
        sha256 = "sha256-RL6Yko0ustm/4Ery/JbNOaZUiQgvSbvQvd4SmQf8oWM=";
      }
      {
        name = "vscode-tailwindcss";
        publisher = "bradlc";
        version = "0.10.2";
        sha256 = "sha256-zh6l1smavdGp7/5yNFVOhGnWZWU/Reb5rJz1D1EY1DU=";
      }
    ];
    userSettings = {
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Bearded Theme Coffee";
    };
  };
}
