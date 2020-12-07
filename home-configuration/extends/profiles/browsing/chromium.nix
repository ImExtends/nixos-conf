{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    extensions = [
      "gpbfjnhlnemfnhajnmkjicfmbagfbejm"
      "dbepggeogbaibhgnhhndojpepiihcmeb"
      "eimadpbcbfnmbkopoojfekhnkhdbieeh"
    ];
  };
}
