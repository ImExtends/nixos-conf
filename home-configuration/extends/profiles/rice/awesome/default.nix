{ pkgs, ... }:
{
  enable = true;
  package = pkgs.awesome;

  #luaModules = with pkgs; [ luaPackages.ruled ];

  xdg.configFile."awesome/utils/init.lua".text = builtins.readFile ./utils/init.lua;
  xdg.configFile."awesome/utils/start.lua".text = builtins.readFile ./utils/start.lua;

  noArgb = true;
}
