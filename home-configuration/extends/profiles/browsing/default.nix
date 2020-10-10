{ config, lib, pkgs, ... }:
let
  cfg = config.profiles.browsing;
  quteBrowser = import ./qutebrowser.nix;

in
{
  options.profiles.browsing = {
    enable = lib.mkEnableOption "Profile to browse with qutebrowser";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      tor-browser-bundle-bin
      firefox

      qt5.qtwebengine
    ];

    programs = { qutebrowser = quteBrowser; };
  };
}
