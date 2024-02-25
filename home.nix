{ config, pkgs, ... }: {
    home.packages = with pkgs; [ 
      firefox
      spotify
      signal-desktop
      vscode
      #vscodium
      yubioath-flutter
      git
    ];

    home.username = "sez";
    home.homeDirectory = "/home/sez";

    programs.home-manager.enable = true;

    #manual.manpages.enable = false;

    programs.bash.enable = true;
    programs.git = {
      enable = true;
      userName  = "Sarah Hägele";
      userEmail = "sarah.haegele01@gmail.com";
    };

    home.stateVersion = "23.11";

    # flakes
    #nix = {
    #  package = pkgs.nix;
    #  settings.experimental-features = [ "nix-command" "flakes" ];
    #};
  }