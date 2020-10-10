{ config, pkgs, lib, inputs, ... }:
let
  cfg = config.extends.nix;
in
{
  options = {
    extends.nix.enable =
      lib.mkEnableOption "Things related to nix (pkgs, paths, GC, etc.)";
  };

  config = lib.mkIf cfg.enable {
    nix = rec {
      package = pkgs.nixUnstable;

      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
        experimental-features = nix-command flakes ca-references
      '';

      autoOptimiseStore = true;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 10d";
      };

      trustedUsers = [
        "extends"
        "root"
        "@wheel"
      ];
    };

    environment.pathsToLink = [ "/libexec" "/share/nix-direnv" ];

    system = {
      autoUpgrade = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}
