{ pkgs, lib, config, ... }:
let
  cfg = config.extends.scripts;
  scripts = import ./scripts.nix { inherit pkgs; };
  baseSystemPackages = with pkgs; [ gnutar gzip bzip2 zip unzip xz unrar ];
in
{
  options = {
    extends.scripts.enable = lib.mkEnableOption
      "Activate scripts like extract or fetch-github (see ./scripts.nix)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.concatLists [ scripts baseSystemPackages ];
  };
}
