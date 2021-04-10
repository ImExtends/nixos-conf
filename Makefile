HOST := $(shell hostname)

build:
	rm /home/extends/.xmonad/xmonad-x86_64-linux && sudo nixos-rebuild switch --flake '.#$(HOST)' -I ./default.nix

flake:
	nix flake update 
	sudo nix build --profile /nix/var/nix/profiles/system/ .#nixosConfigurations.sigma.config.system.build.toplevel

rebuild:
	sudo nix build --profile /nix/var/nix/profiles/system/ .#nixosConfigurations.sigma.config.system.build.toplevel

total-build: flake build
	flake build
