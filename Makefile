HOST := $(shell hostname)

build:
	sudo nixos-rebuild switch --flake '.#$(HOST)' -I ./default.nix

flake:
	nix flake update 
	nix build

total-build: flake build
	flake build
