{ pkgs, ... }:
let
  var =
    "escrotum 'Screenshot_%Y-%m-%d-%H%M.png' -e 'mv Screenshot_%Y-%m-%d-%H%M.png /home/extends/Images/Screenshots/'";
  background = toString (
    pkgs.fetchurl {
      url =
        "https://cdn.discordapp.com/attachments/635625973764849684/736988151331029052/discord-send.png";
      sha256 = "1p2vpp669jnmsqgvlhr1vkmf09v7w1wwh16p67j0fdj5a29mfw0b";
    }
  );
in
{
  enable = true;
  package = pkgs.callPackage ./i3-patched.nix { };

  config = {
    assigns = {
      "2" = [{ class = "qutebrowser"; }];
      "3" = [{ class = "discord"; }];
      "4" = [{ class = "electronplayer"; }];
    };

    terminal = "kitty";

    gaps = {
      inner = 15;
      outer = 5;

      smartBorders = "on";
    };

    bars = [ ];

    window = {
      hideEdgeBorders = "smart";
      commands = [
        {
          command = "border pixel 0";
          criteria = { class = "^.*"; };
        }
        {
          command = "move to workspace 4";
          criteria = { class = "Spotify"; };
        }
        {
          command = "floating enable";
          criteria = { class = "kitty"; };
        }
      ];
    };

    modes = {
      resize = {
        Left = "resize shrink width 10 px or 10 ppt";
        j = "resize shrink width 10 px or 10 ppt";
        Down = "resize grow height 10 px or 10 ppt";
        k = "resize grow height 10 px or 10 ppt";
        Up = "resize shrink height 10 px or 10 ppt";
        l = "resize shrink height 10 px or 10 ppt";
        Right = "resize grow width 10 px or 10 ppt";
        m = "resize grow width 10 px or 10 ppt";

        Return = "mode default";
        Escape = "mode default";
      };
    };

    keybindings =
      let
        mod = "Mod1";
      in
      with pkgs; {
        XF86AudioRaiseVolume =
          "exec ${pulseaudioFull}/bin/pactl set-sink-volume 0 +5%";
        XF86AudioLowerVolume =
          "exec ${pulseaudioFull}/bin/pactl set-sink-volume 0 -5%";
        XF86AudioMute = "exec ${pulseaudioFull}/bin/pactl set-sink-mute 0 toggle";
        XF86AudioMicMute =
          "exec ${pulseaudioFull}/bin/pactl set-source-mute 0 toggle";
        XF86MonBrightnessDown = "exec brightnessctl set 4%-";
        XF86MonBrightnessUp = "exec brightnessctl set 4%+";

        "${mod}+Return" = "exec ${kitty}/bin/kitty";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec ${rofi}/bin/rofi -show run drun window";

        "${mod}+Left" = "focus left";
        "${mod}+Right" = "focus right";
        "${mod}+Up" = "focus up";
        "${mod}+Down" = "focus down";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Right" = "move right";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Down" = "move down";

        "${mod}+h" = "split h";
        "${mod}+v" = "split v";

        "${mod}+f" = "fullscreen toggle";

        "${mod}+s" = "layout stacking";
        "${mod}+z" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

        "${mod}+q" = "focus parent";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+e" =
          "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

        "${mod}+r" = "mode resize";

        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+0" = "workspace 10";

        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "${mod}+Shift+6" = "move container to workspace 6";
        "${mod}+Shift+7" = "move container to workspace 7";
        "${mod}+Shift+8" = "move container to workspace 8";
        "${mod}+Shift+9" = "move container to workspace 9";
        "${mod}+Shift+0" = "move container to workspace 10";

        "Print" = ''
          exec ${escrotum}/bin/${var} && ${libnotify}/bin/notify-send -i "/home/extends/Images/Screenshots/$(${var})" "$(${var}) saved" -t 2500'';

        "Shift+Print" =
          "exec ${maim}/bin/maim -u -s | ${xclip}/bin/xclip -sel clip -t image/png";
      };

    startup = with pkgs; [
      {
        command = "${feh}/bin/feh --bg-fill ${background}";
        always = true;
      }
      {
        command = "--no-startup-id ${qutebrowser}/bin/qutebrowser";
        always = false;
      }
      {
        command =
          "--no-startup-id electronplayer";
        always = false;
      }
      {
        command = "--no-startup-id ${discord}/bin/Discord";
        always = false;
      }
      {
        command =
          "${xautolock}/bin/xautolock -time 35 -locker 'betterlockscreen --lock blur -u $HOME/Images/Wallpapers/rocky-shore.jpg' &";
        always = true;
      }
    ];

    fonts = with pkgs;
      [
        "${nerdfonts}/share/fonts/truetype/NerdFonts/Fura Code Retina Nerd Font Complete Mono.ttf"
      ];
  };
}
