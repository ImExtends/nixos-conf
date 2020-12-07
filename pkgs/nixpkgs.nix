{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    master.discord
    master.firefox
  ];
}
