{ lib, config, ... }:
let
  cfg = config.extends.utils.lang;

  fr = {
    i18n.defaultLocale = "fr_FR.UTF-8";
    time.timeZone = "Europe/Paris";
  };
  us = {
    i18n.defaultLocale = "us_US.UTF-8";
    time.timeZone = "America/Chicago";
  };
in
{
  options = {
    extends.utils.lang = {
      enable = lib.mkEnableOption "Bonjour la France, baguette";
      language = lib.mkOption {
        default = null;
        type = lib.types.str;
        description = "Which lang to use";
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        console = {
          font = "Lat2-Terminus16";
          keyMap = cfg.language;
        };
      }
      (lib.mkIf (cfg.language == "fr") fr)
      (lib.mkIf (cfg.language == "us") us)
    ]
  );
}
