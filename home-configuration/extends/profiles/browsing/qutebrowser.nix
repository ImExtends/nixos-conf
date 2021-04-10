{
  enable = true;

  extraConfig = ''
    padding = { 'bottom': 24, 'left': 11, 'right': 20, 'top': 23 }
    padding2 = { 'bottom': 0, 'left': 0, 'right': 8, 'top': 0 }
    c.tabs.padding = padding
    c.tabs.indicator.padding = padding2
    c.statusbar.padding = padding2
  '';

  searchEngines = {
    DEFAULT = "https://duckduckgo.com?q={}";
    git = "https://github.com/search?q={}";
    pkg =
      "https://nixos.org/nixos/packages.html?channel=nixpkgs-unstable&query={}";
    yt = "https://www.youtube.com/results?search_query={}";
  };

  settings = {
    downloads.location.directory = "/home/extends/Downloads";
    url = {
      start_pages =
        "/nixos-conf/home-configuration/extends/profiles/browsing/index.html";
      default_page =
        "/nixos-conf/home-configuration/extends/profiles/browsing/index.html";
    };

    tabs = {
      position = "left";
      background = true;
      show = "multiple";
      title.format = "{index}";
      width = 42;
      favicons.scale = 1.8;
      indicator = { width = 0; };
    };

    fonts = {
      default_size = "9pt";
      default_family = "FuraCode NF";
      downloads = "FuraCode NF";
      statusbar = "FuraCode NF";
    };

    scrolling.smooth = true;

    colors = {
      webpage.prefers_color_scheme_dark = true;

      statusbar = {
        caret = {
          bg = "#394f55";
          fg = "#a2a4a6";
          selection = {
            bg = "#a12dff";
            fg = "#394f55";
          };
        };
        command = {
          bg = "#191919";
          fg = "#a2a4a6";
          private = {
            fg = "#a2a4a6";
            bg = "#a2a4a6";
          };
        };
        insert = {
          bg = "#24323c";
          fg = "#a2a4a6";
        };
        normal = {
          bg = "#191919";
          fg = "#a2a4a6";
        };
        passthrough = {
          bg = "#2d3f43";
          fg = "#a2a4a6";
        };
        private = {
          bg = "#666666";
          fg = "#a2a4a6";
        };
        progress.bg = "#a2a4a6";
        url = {
          fg = "#a2a4a6";
          hover.fg = "#4c514c";
          success.https.fg = "#a2a4a6";
          warn.fg = "#343434";
        };
      };

      completion = {
        category = {
          bg = "#191919";
          border.bottom = "#46494d";
          border.top = "#191919";
          fg = "#46494d";
        };
        even.bg = "#191919";
        item = {
          selected = {
            bg = "#191919";
            border.bottom = "#191919";
            border.top = "#191919";
            fg = "#a2a4a6";
          };
        };
        match.fg = "#a2a4a6";
        odd.bg = "#191919";
      };

      downloads = {
        bar.bg = "#191919";
        error.bg = "#1f2c31";
        error.fg = "#a2a4a6";
        start.bg = "#24323c";
        start.fg = "#a2a4a6";
        stop.bg = "#191919";
        stop.fg = "#a2a4a6";
        system.bg = "none";
        system.fg = "none";
      };

      hints.fg = "#191919";
      hints.match.fg = "#24323c";

      tabs = {
        bar.bg = "#232323";
        even.bg = "#232323";
        even.fg = "#191919";
        indicator.error = "#ff0000";
        odd.bg = "#232323";
        odd.fg = "#a2a4a6";
        selected.even.bg = "#191919";
        selected.even.fg = "#343434";
        selected.odd.bg = "#191919";
        selected.odd.fg = "#343434";
      };
    };
  };
}
