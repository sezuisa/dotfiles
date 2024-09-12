{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      schlago = {
        host = "schlago";
        hostname = "schlago.hoenle.xyz";
        port = 23235;
        user = "guest";
        identityFile = [
          "~/.ssh/schlag-o-meter/id_ed25519"
        ];
      };
    };
  };
}
