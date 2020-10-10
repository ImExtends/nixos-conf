{ config, lib, pkgs, ... }:
let
  cfg = config.nixosUsers;
in
{
  options = { nixosUsers = { extends = lib.mkEnableOption "My profile"; }; };
  config = lib.mkIf cfg.extends {
    users.users.extends = import ./extends.nix { inherit pkgs config lib; };
    programs.fish.enable = config.users.users.extends.shell == pkgs.fish;
    home-manager.users.extends = {
      imports = [ ../home-configuration/extends/home.nix ];
    };
  };
}
