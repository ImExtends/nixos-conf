{ ... }: {
  enable = true;

  settings = {
    global = {
      monitor = 0;
      follow = "mouse";
      font = "DroidSansMono Nerd Font Mono 10";
      markup = "full";
      geometry = "400x5-0+50";
      indicate_hidden = "yes";
      shrink = "no";
      transparency = 5;
      notification_height = 0;
      separator_height = 2;
      padding = 8;
      horizontal_padding = 8;
      separate_color = "frame";
      sort = "yes";
      line_height = 0;
      format = ''
        <b>%p%n%s</b>
        %b'';
      alignement = "left";
      show_age_threshold = 60;
      word_wrap = "yes";
      ellipsize = "middle";
      ignore_newline = "no";
      stack_duplicates = true;
      hide_duplicate_count = true;
      show_indicators = "yes";
      icon_position = "left";
      max_icon_size = 32;
      sticky_history = "yes";
      history_length = 20;
      always_run_script = true;
      title = "Dunst";
      class = "Dunst";
      startup_notification = false;
      force_xinerama = false;
      mouse_left_click = "do_action";
      mouse_middle_click = "none";
      mouse_right_click = "close_all";
    };

    experimental = { per_monitor_dpi = false; };

    urgency_low = {
      background = "#191918";
      foreground = "#ffffff";
      timeout = 10;
    };

    urgency_normal = {
      background = "#191918";
      foreground = "#ffffff";
      timeout = 7;
    };

    urgency_critical = {
      background = "#191918";
      foreground = "#ffffff";
      timeout = 10;
    };
  };
}
