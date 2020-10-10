{ pkgs, lib, config, ... }:
{
  fish_greeting = {
    body = ''
      pfetch
    '';
    description = "fish greeting message";
  };
}
