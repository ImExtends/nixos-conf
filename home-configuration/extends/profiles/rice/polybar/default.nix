{ pkgs, ... }:
let
  background = "#00000000";
  foreground = "#ffffff";
in
{
  enable = true;
  package = pkgs.polybar.override {
    alsaSupport = true;
    githubSupport = true;
  };

  script = "polybar -q -r top &";

  config = {
    "global/wm" = {
      margin-bottom = 0;
      margin-top = 0;
    };

    "bar/top" = {
      bottom = false;
      fixed-center = true;
      width = "100%";
      heigth = 19;

      offset-x = "0%";
      offset-y = "0%";

      background = background;
      foreground = foreground;

      font-0 = "FuraCode Nerd Font:size=12;3";
      font-1 = "FuraCode Nerd Font:style=Bold:size=12;3";

      radius = 0;

      modules-left = "date";
      modules-center = "";
      modules-right = "";

      locale = "fr_FR.UTF-8";
    };

    "settings" = {
      throttle-output = 5;
      throttle-output-for = 10;
      throttle-input-for = 30;

      screenchange-reload = true;
      compositing-background = "source";
      compositing-foreground = "over";
      compositing-overline = "over";
      comppositing-underline = "over";
      compositing-border = "over";

      pseudo-transparency = "false";
    };

    #Gaps transition

    "module/ddlT" = {
      type = "custom/text";
      content = "";
      content-foreground = background;
      content-background = background;
    };

    "module/durP" = {
      type = "custom/text";
      content = "";
      content-foreground = background;
      content-background = background;
    };

    #Modules

    "modules/nixos-icon" = {
      type = "custom/script";
      exec = "uname -r | cut -d- -f1";
      interval = "99999999";

      format = " <label>";
      format-background = background;
      format-foreground = background;
      format-padding = 1;

      label = "%output%";
      label-font = 2;
    };

    "module/date" = {
      type = "internal/date";

      interval = "1.0";

      time = "%H:%M:%S";
      time-alt = "%Y-%m-%d";

      format = "<label>";
      format-padding = 4;
      format-foreground = foreground;

      label = "%time%";
    };
  };
}
