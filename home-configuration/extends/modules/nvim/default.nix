{ pkgs, ... }: { programs.neovim = import ./neovim.nix { inherit pkgs; }; }
