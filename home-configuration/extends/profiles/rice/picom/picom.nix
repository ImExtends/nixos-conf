{ pkgs, ... }: {
  enable = true;
  package = pkgs.callPackage ./picom-ibhagwan.nix { };

  blur = true;
  blurExclude = [ "window_type = 'dock'" "window_type = 'desktop'" ];

  fade = true;
  fadeDelta = 5;
  fadeSteps = [ "0.03" "0.03" ];

  refreshRate = 60;

  shadow = true;
  shadowOffsets = [ (-20) (-20) ];
  shadowOpacity = "1";

  backend = "glx";
  vSync = true;

  extraOptions = ''
    glx-no-stencil = true;
    glx-copy-from-front = false;
    undir-if-possible = true;
    shadow-radius = 20;
    corner-radius = 10.0;
    clear-shadow = true;
    frame-opacity = 0.7;

    blur-method = "dual_kawase";
    blur-strength = 10;
    blur-size = 14;
    blur-background-frame = false;

    alpha-step = 0.06;
    detect-client-opacity = true;
    detect-rounded-corners = true;
    detect-transient = true;
    mark-wmwin-focused = true;
    mark-overdir-focused = true;
    shadow-ignore-shaped = false;
    dbe = false;
  '';
}
