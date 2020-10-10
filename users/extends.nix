{ pkgs, config, lib, ... }:
let
  groupExists = grp: builtins.hasAttr grp config.users.groups;
  addIfExists = group: lib.optional (groupExists group) group;
in
{
  shell = pkgs.fish;
  home = "/home/extends";
  isNormalUser = true;
  extraGroups = [ "wheel" "tty" "audio" "disk" ] ++ addIfExists "docker";
  hashedPassword = "$6$R.NrrktIQ$abEUA6gMBxls2UIsvFBUbV.0HXBmNIGlkwi1JstOKsWfqiRLEoXrykI/TYTNoD4bQCEi1udnx5hpHDm/yapPU.";
  openssh.authorizedKeys.keys = import ../laptop/utils/keys.nix;
}
