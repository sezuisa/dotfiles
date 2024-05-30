{
  programs.wofi = {
    enable = true;
    style = ''
      * {
          font-family: "JetBrains Mono";
          background-color: transparent;
          color: white;
      }
      window {
          background-color: black;
          border-radius: 10px;
          border: 2px solid #96724e;
      }
      #entry:selected {
          background-color: #96724e;
          color: white;
      }
    '';
  };
}
