{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    master.discord
  ];
}
