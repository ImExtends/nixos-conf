{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #(import ./discord_patched.nix { inherit pkgs; })
    discord
  ];
}
