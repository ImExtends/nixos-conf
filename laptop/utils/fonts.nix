{ pkgs, config, lib, ... }:
let
  cfg = config.extends.utils.fonts;
in
{
  options.extends.utils.fonts = {
    enable = lib.mkEnableOption "Wether to enable download fonts (takes a lot of time lol)";
  };
  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ (import ../nix-nerd-fonts-overlay/default.nix) ];

    fonts = {
      enableDefaultFonts = true;
      fontDir.enable = true;

      fonts = with pkgs; [
        nerd-fonts.droidsansmono
        nerd-fonts.firacode
        nerd-fonts.jetbrainsmono
        corefonts
        dejavu_fonts
        source-code-pro
        ubuntu_font_family
      ];
    };
  };
}
