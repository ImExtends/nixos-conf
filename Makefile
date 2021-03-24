HOST := $(shell hostname)

build:
	nix flake update && sudo nixos-rebuild switch --flake '.#$(HOST)' -I ./default.nix

flake:
	nix flake update --recreate-lock-file --commit-lock-file

total-build: flake build
	flake build
