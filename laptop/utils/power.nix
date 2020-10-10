{ config, pkgs, lib, ... }:
let
  cfg = config.extends.utils.power;
in
{
  options = {
    extends.utils.power = {
      enable = lib.mkEnableOption "Enable power adjustments for laptops.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tlp.enable = true;
    powerManagement.powertop.enable = true;
    services.upower.enable = true;

    environment.systemPackages = with pkgs; [ powertop ];
  };
}
