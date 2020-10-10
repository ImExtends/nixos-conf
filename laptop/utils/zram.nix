{ config, lib, ... }:
let
  cfg = config.extends.utils.zram;
in
{
  options = {
    extends.utils.zram = {
      enable = lib.mkEnableOption "Activate zram swap";
    };
  };

  config = lib.mkIf cfg.enable {
    zramSwap = {
      enable = true;
      priority = 5;
      memoryPercent = 200;
      swapDevices = 1;
      algorithm = "zstd";
    };
  };
}
