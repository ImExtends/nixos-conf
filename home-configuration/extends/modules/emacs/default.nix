{ pkgs, ... }:

{
  programs.emacs = import ./emacs.nix { inherit pkgs; };
}
