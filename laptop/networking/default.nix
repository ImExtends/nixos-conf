{ config, lib, pkgs, ... }:
let
  cfg = config.extends.networking;
in
{
  options = {
    extends.networking.enable =
      lib.mkEnableOption "Enables networking system-wide";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      hostName = "sigma";
      hostId = "ae8e3fc0";

      wireless = {
        enable = true;
        networks = {
          Freebox-666A7D = {
            pskRaw = "a39b9ab29813affcf56599909518dcaabf0ae0f8df922857e8191db571ddabfa";
          };
          Nix_ext2962 = {
            pskRaw = "371a0c4bb9f0b2acf0af1314002730c2cafbc32e12b817ff975da7f316a02365";
          };
          AndroidAP7960 = {
            pskRaw = "2eb40b7ec9d0263239a458e66c1a88fbe8551e40670d9d789715673dcd9839ac";
          };
        };
      };

      interfaces = {
        enp2s0.useDHCP = true;
        wlo1.useDHCP = true;
      };

      firewall = {
        allowPing = true;
        allowedTCPPorts = [ 3000 8080 6697 ];
        allowedUDPPorts = [ 4294 984 ];
      };

      wg-quick.interfaces = {
        wg0 = {
          address = [ "10.6.0.2/24" ];
          peers = [
            {
              allowedIPs = [ "192.168.1.0/24" "10.6.0.0/24" "192.168.43.143/24" ];
              endpoint = "88.123.145.86:984";
              publicKey = "RANZW0JVDqbKrg8pQ4V/CBpGFAardkFBxAgMdNS8RU4=";
              presharedKeyFile = "/home/extends/.nix-tests/.psk";
              persistentKeepalive = 25;
            }
          ];
          privateKeyFile = "/home/extends/.nix-tests/.pvk";
          dns = [ "10.6.0.1" ];
        };
      };
    };

    services.openssh = {
      enable = true;
      ports = [ 48896 ];
      permitRootLogin = "yes";
    };

    virtualisation.docker.enable = true;
  };
}
