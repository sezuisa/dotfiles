{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Birds Of Paradise";
    font = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
      size = 14;
    };
    settings = {
      background_opacity = "0.8";
      enabled_layouts = "Splits";
      symbol_map = "U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d4,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f532,U+f0001-U+f1af0 Symbols Nerd Font Mono";
    };
    # keybindings = {
    #   # Create a new window splitting the space used by the existing one so that
    #   # the two windows are placed one above the other
    #   "f5" = "launch --location=hsplit";

    #   # Create a new window splitting the space used by the existing one so that
    #   # the two windows are placed side by side
    #   "f6" = "launch --location=vsplit";

    #   # Create a new window splitting the space used by the existing one so that
    #   # the two windows are placed side by side if the existing window is wide or
    #   # one above the other if the existing window is tall.
    #   "f4" = "launch --location=split";

    #   # Rotate the current split, changing its split axis from vertical to
    #   # horizontal or vice versa
    #   "f7" = "layout_action rotate";

    #   # Move the active window in the indicated direction
    #   "shift+up" = "move_window up";
    #   "shift+left" = "move_window left";
    #   "shift+right" = "move_window right";
    #   "shift+down" = "move_window down";

    #   # Move the active window to the indicated screen edge
    #   "ctrl+shift+up" = "layout_action move_to_screen_edge top";
    #   "ctrl+shift+left" = "layout_action move_to_screen_edge left";
    #   "ctrl+shift+right" = "layout_action move_to_screen_edge right";
    #   "ctrl+shift+down" = "layout_action move_to_screen_edge bottom";

    #   # Switch focus to the neighboring window in the indicated direction
    #   "ctrl+left" = "neighboring_window left";
    #   "ctrl+right" = "neighboring_window right";
    #   "ctrl+up" = "neighboring_window up";
    #   "ctrl+down" = "neighboring_window down";
    # };
  };
}
