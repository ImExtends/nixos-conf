{ config, pkgs, ... }:
let
  homeDirectory = "/home/extends";
in
rec {
  imports = [ ./modules ./profiles ];

  profiles = {
    base.enable = true;
    browsing.enable = true;
    development = {
      enable = true;
      shell = "fish";
    };
    rice.enable = true;
  };

  xdg = {
    enable = true;
    cacheHome = homeDirectory + "/.local/cache";
    configHome = homeDirectory + "/.config";
    dataHome = homeDirectory + "/.local/share";
  };

  home = {
    username = "extends";
    homeDirectory = homeDirectory;
    stateVersion = "20.09";
  };
}
