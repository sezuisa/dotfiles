{ pkgs, ... }:
let
  preview_script = pkgs.writeShellScript "lf_kitty_preview.sh"
    ''
      #!/bin/sh

      file=$1
      w=$2
      h=$3
      x=$4
      y=$5

      if [[ "$( file -Lb --mime-type "$file")" =~ ^image ]]; then
          kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
          exit 1
      fi

      pistol "$file"  
    '';
  clean_script = pkgs.writeShellScript "lf_kitty_clean.sh"
    ''
      kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
    '';
in
{
  programs.lf = {
    enable = true;
    previewer = {
      source = "${preview_script}";
    };
    settings = {
      cleaner = "${clean_script}";
    };
    keybindings = {
      a = ":push %mkdir<space>";
      r = "push :rename<space>";
      t = "trash";
      "<delete>" = "delete";
    };
    commands = {
      rename = "%[ -e $1 ] && printf \"file exists\" || mv $f $1";
      trash = "%set -f; mv $fx ~/.trash";
      delete = ''
        ''${{
        set -f
        printf "$fx\n"
        printf "delete?[y/n]"
        read ans
        [ "$ans" = "y" ] && rm -rf $fx
        }}
      '';
    };
    extraConfig = ''
      %mkdir -p ~/.trash
    '';
  };
}
