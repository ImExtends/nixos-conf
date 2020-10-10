{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nur.repos.extends.bashtop
    pkgs.nur.repos.extends.cordless
    pkgs.nur.repos.extends.giph

    pkgs.nur.repos.kampka.nixify
  ];
}
