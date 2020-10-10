{ pkgs, config, lib, ... }:
let
  cfg = config.extends.xserver.lightdm;
in
{
  options = {
    extends.xserver.lightdm.enable = lib.mkEnableOption "Do I really need to explain ?";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.displayManager = {
      lightdm = {
        enable = true;

        background = toString (
          pkgs.fetchurl {
            url = "https://github.com/gvolpe/nix-config/blob/d9fb86c908b99b6f7b04d7c70eac44059356f58a/home/nixos.png?raw=true";
            sha256 = "sha256:0l8zvq0qb3ay21vaf5ayabzy324blnxw0bn3nzf38q1bprkxh4bd";
          }
        );

        greeters.gtk = {
          indicators = [ "~host" "~spacer" "~clock" "~spacer" "~session" "~language" "~ally" "~power" ];
          theme = {
            package = pkgs.arc-theme;
            name = "Arc-Dark";
          };
        };
      };
      defaultSession = "none+xmonad";
    };
  };
}
