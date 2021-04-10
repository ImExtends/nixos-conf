{ pkgs, ... }: {
  enable = true;
  extraPackages = haskellPackages:
    with haskellPackages; [
      xmonad-contrib
      xmonad-extras
      xmonad
      monad-logger
      dbus
    ];
  enableContribAndExtras = true;

  config = pkgs.writeText "xmonad.hs" "${builtins.readFile ./xmonad.hs}";
}
