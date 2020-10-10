{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.profiles.base;
in
{
  options.profiles.base = {
    enable = lib.mkEnableOption "Basic profile enabled";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = rec {
      EDITOR = "nvim";
      VISUAL = "nvim";
      GIT_EDITOR = EDITOR;
    };

    home.keyboard.layout = "fr";
    home.packages = (
      with pkgs; [
        killall
        acpi
        xclip
        avahi
        brightnessctl
        most

        canon-cups-ufr2

        nix-index
        nixpkgs-review
        direnv
        niv

        travis
        amarok
      ]
    ) ++ (
      lib.optionals
        (
          config.xsession.windowManager.xmonad.enable
            || config.xsession.windowManager.i3.enable
        )
        (
          with pkgs; [
            gnome3.gucharmap
            gimp
            libreoffice-fresh
          ]
        )
    );

    programs = {
      home-manager.enable = true;
      htop.enable = true;
      kitty = import ./kitty.nix { };
      alacritty = import ./alacritty.nix { inherit pkgs; };

      direnv = {
        enable = true;
        enableNixDirenvIntegration = true;
        enableFishIntegration = true;
      };

      irssi = {
        enable = true;
        networks.freenode = {
          nick = "Extends";
          server = {
            address = "chat.freenode.net";
            port = 6697;
            autoConnect = true;
          };
          channels = { nixos.autoJoin = true; };
        };
      };
    };
    services = { lorri.enable = true; };
  };
}
