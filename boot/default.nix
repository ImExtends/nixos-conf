{ config, lib, pkgs, ... }:
let
  cfg = config.boot;
in
{
  options = {
    boot.enable =
      lib.mkEnableOption "Needed for boot, concerns zfs / kernel etc";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      supportedFilesystems = [ "zfs" ];
      zfs.requestEncryptionCredentials = true;

      kernelParams = [ "zfs.zfs_arc_max=12884901888" ];
      kernelPackages = pkgs.linuxPackages_latest;

      loader = { efi.canTouchEfiVariables = true; };
      cleanTmpDir = true;

      loader.grub = {
        enable = true;

        efiSupport = true;
        device = "nodev";

        zfsSupport = true;

        fontSize = 12;
        splashImage = toString (
          pkgs.fetchurl {
            url =
              "https://cdn.discordapp.com/attachments/635625973764849684/731847328247447572/wallhaven-ymp92k_1920x1080.png";
            sha256 = "0a1p72dhlgysnvfdhjwn0kqhv3n32jmjfgw6rs3ggjwh3bj9krj9";
          }
        );
      };
    };

    services.zfs = {
      autoSnapshot.enable = true;
      autoScrub.enable = true;
    };
  };
}
