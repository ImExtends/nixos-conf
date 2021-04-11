{ pkgs, lib, config, ... }:
let
  cfg = config.profiles.rice;
in
{
  options.profiles.rice = {
    enable = lib.mkEnableOption "A profile for ricing :)";
  };

  imports = [ ./awesome/files.nix ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        arc-theme
        breeze-icons
        capitaine-cursors
        feh
        pipes
        ranger
        xautolock
        fira-code
      ] ++ lib.optionals config.xsession.windowManager.xmonad.enable [
        electronplayer
        escrotum
        maim
        libnotify
        lxappearance
        betterlockscreen
        spotify
      ];

    services = lib.mkIf config.xsession.windowManager.xmonad.enable {
      picom = import ./picom/picom.nix { inherit pkgs; };
      dunst = import ./dunst { };
      polybar = import ./polybar { inherit pkgs; };
    };

    home.file.".xmonad/lib/Rofi.hs".text =
      builtins.readFile ./xmonad/lib/Rofi.hs;
    home.file.".config/awesome/rc.lua".text = 
      builtins.readFile ./awesome/rc.lua;

    xsession = {
      enable = true;
      #windowManager.xmonad = import ./xmonad { inherit pkgs; };
      windowManager.awesome = import ./awesome { inherit pkgs; };
    };

    programs = lib.mkIf
      (
        config.xsession.windowManager.xmonad.enable
        || config.xsession.windowManager.i3.enable
        || config.xsession.windowManager.awesome.enable
      )
      {
        rofi = import ./rofi { inherit pkgs; };
        zathura = import ./zathura { };
      };
  };
}
