{ pkgs, ... }:
let
  background = "#bf1692";
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

      radius = 0;

      modules-left = "";
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

    "module/date" = {
      type = "internal/date";

      interval = "1.0";

      time = "%H:%M:%S";
      time-alt = "%Y-%m-%d";

      format = "<label>";
      format-padding = 4;
      format-foreground = fg;

      label = "%time%";
    };
  };
}
