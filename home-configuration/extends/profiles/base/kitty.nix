{ ... }: {
  enable = true;

  settings = {
    disable_ligatures = "never";
    font_family = "DejaVuSansMono Nerd Font Mono";
    background = "#191918";
    window_padding_width = 20;
    background_opacity = "0.85";
  };

  keybindings = {
    "ctrl+c" = "copy_or_interrupt";
    "ctrl+v" = "paste_or_interrupt";
  };

  extraConfig = ''
    color0 #1c2023
    color1 #c7ae95

    color2 #95c7ae
    color3 #aec795

    color4 #ae95c7
    color5 #c795ae

    color6 #95aec7
    color7 #c7ccd1

    # bright
    color8 #747c84
    color9 #c7c795

    color10 #393f45
    color11 #565e65

    color12 #adb3ba
    color13 #dfe2e5

    color14 #c79595
    color15 #f3f4f5
  '';
}
