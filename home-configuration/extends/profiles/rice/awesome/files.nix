{ ... }:
{
  xdg.configFile."awesome/utils/init.lua".text = builtins.readFile ./utils/init.lua;
  xdg.configFile."awesome/utils/start.lua".text = builtins.readFile ./utils/start.lua;
  xdg.configFile."awesome/bar/init.lua".text = builtins.readFile ./bar/init.lua;
  xdg.configFile."awesome/bar/wibar.lua".text = builtins.readFile ./bar/wibar.lua;
}
