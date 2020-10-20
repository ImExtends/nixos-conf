{ pkgs }:
pkgs.master.discord.override {
  nss = pkgs.stable.nss;
}
