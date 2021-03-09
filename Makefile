build:
	sudo nixos-rebuild switch --flake '.#sigma'

flake:
	nix flake update --recreate-lock-file --commit-lock-file

total-build: build flake
	build flake
