{ lib, ... }: {
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "rpool/nixos/root";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "rpool/nixos/home";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "rpool/store/nix";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5CFB-0BCB";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/b1733d47-8773-474f-b8fc-e43e855a3ce2"; }];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
