{ ... }: {

  imports = [ ./boot ./users ];

  #Needed
  nixosUsers.extends = true;
  boot.enable = true;

  system.stateVersion = "21.03";
}
