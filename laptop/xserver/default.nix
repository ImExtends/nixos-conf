{ pkgs, config, lib, ... }:
let
  cfg = config.extends.xserver.utils;
in
{
  imports = [ ./displayManager.nix ];
  options = {
    extends.xserver.utils.enable = lib.mkEnableOption "You understand what it does at this point, at least I hope so lol";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      layout = "fr";
      xkbOptions = "eurosign:e";

      libinput = {
        enable = true;
        scrollMethod = "twofinger";
        tapping = false;
      };

      #windowManager.i3.enable = true;
      windowManager.xmonad.enable = true;
    };
  };
}
