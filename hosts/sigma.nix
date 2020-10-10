{ inputs, ... }: {
  imports = [
    "${inputs.hardware}/common/cpu/intel"
    "${inputs.hardware}/common/pc/laptop"
    ../laptop/utils
    ../laptop/nix
    ../laptop/scripts
    ../laptop/networking
    ../laptop/xserver
    ../hardware-configuration/sigma-hardware.nix
    ../pkgs/nur.nix
    ../pkgs/nixpkgs.nix
  ];
  #Needed
  extends.utils.sound.enable = true;

  #Other stuff that you may not want
  extends.utils = {
    fonts.enable = true;
    printing.enable = true;
    zram.enable = true;
    lang = {
      enable = true;
      language = "fr";
    };
    power.enable = true;
  };

  extends.scripts.enable = true;
  extends.xserver = {
    lightdm.enable = true;
    utils.enable = true;
  };

  extends.nix.enable = true;
  extends.networking.enable = true;
}
