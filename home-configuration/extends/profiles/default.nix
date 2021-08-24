{ ... }: {
	imports = [ ./base ./browsing ./development ./rice ]; 
	nixpkgs.config.allowUnfree = true;
}
