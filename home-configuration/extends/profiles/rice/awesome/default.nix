{ pkgs, ... }:
{
  enable = true;
  package = pkgs.awesome;

  #luaModules = with pkgs; [ luaPackages.ruled ];

  noArgb = true;
}
