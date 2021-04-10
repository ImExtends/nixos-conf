{ pkgs, ... }: {
  enable = true;

  settings = {
    window = {
      title = "Terminal";
      dimensions = {
        lines = 75;
        columns = 100;
      };
    };

    font = {
      normal.family =
        "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/Fura Code Retina Nerd Font Complete.otf";
      size = 8.0;
    };

    background_opacity = 0.85;

    shell = { program = "${pkgs.zsh}/bin/zsh"; };

    colors = {
      primary = {
        background = "#161821";
        foreground = "#D8DEE9";
      };
      normal = {
        black = "#3B4252";
        red = "#BF616A";
        green = "#A3BE8C";
        yellow = "#EBCB8B";
        blue = "#81A1C1";
        magenta = "#B48EAD";
        cyan = "#88C0D0";
        white = "#E5E9F0";
      };
      bright = {
        black = "#4C566A";
        red = "#BF616A";
        green = "#A3BE8C";
        yellow = "#EBCB8B";
        blue = "#81A1C1";
        magenta = "#B48EAD";
        cyan = "#8FBCBB";
        white = "#ECEFF4";
      };
    };
  };
}
