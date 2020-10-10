# Small file, only contains stuff to enable sound, which will be enabled by default
{ config, lib, ... }:
let
  cfg = config.extends.utils.sound;
in
{
  options = {
    extends.utils.sound.enable = lib.mkEnableOption "Enables sound, will be automatically enabled";
  };

  config = lib.mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = true;
  };
}
