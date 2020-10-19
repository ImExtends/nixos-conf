{ inputs, ... }: {

  imports = [ ./boot ./users ];

  #Needed
  nixosUsers.extends = true;
  boot.enable = true;

  environment.systemPackages = [
    inputs.master.discord
  ];

  system.stateVersion = "21.03";
}
