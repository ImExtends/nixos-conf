{ pkgs, config, lib, ... }:
let
  cfg = config.extends.utils.printing;
in
{
  options = {
    extends.utils.printing = {
      enable = lib.mkEnableOption "Download drivers needed for priting and all that stuff";
    };
  };
  config = lib.mkIf cfg.enable {
    nixpkgs.config = { allowUnfree = true; };
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        cups-bjnp
        hplip
        gutenprint
        gutenprintBin
      ];
    };
  };
}
