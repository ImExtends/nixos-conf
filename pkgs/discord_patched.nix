with import <nixpkgs> {};
pkgs.master.discord.override {
  nss = pkgs.stable.nss;
}
