{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nur.repos.extends.giph

    pkgs.nur.repos.kampka.nixify
  ];
}
