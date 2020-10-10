{ pkgs, ... }:
let
  fishFunctions = pkgs.callPackage ./functions.nix { };
  themeConfig = ''
    bind \co 'fg 1>&2 2>/dev/null ; commandline -f repaint'

    set -gx VISUAL "nvim"
    set -gx EDITOR "nvim"
    set -gx fish_color_normal normal
    set -gx fish_color_command blue
    set -gx fish_color_param white
    set -gx fish_color_quote yellow
    set -gx fish_color_error red
    set -gx fish_color_redirection blue
    set -gx fish_color_escape blue
    set -gx fish_color_end blue
    set -gx fish_color_autosuggestion 808080
  '';
  exConfig = ''
    set -q XDG_DATA_HOME > /dev/null 2>&1

    export TERM=xterm
    export NIXOS_VERSION=(cat /etc/os-release | grep PRETTY_NAME | cut -d ' ' -f 2)
    export PATH="/home/extends/.local/bin:$PATH" > /dev/null 2>&1
    fish_vi_key_bindings

    eval (direnv hook fish)
  '';
in
{
  enable = true;
  shellInit = exConfig + themeConfig;
  shellAbbrs = {
    l = "ls -lah";
    gst = "git status";
    grm = "git remote";
    gr = "git rm";
    ga = "git add";
    gc = "git commit";
    gph = "git push";
    gd = "git diff";
    gpl = "git pull";
    pipes = "pipes.sh";
    ".." = "cd ../";
    poweroff = "systemctl poweroff";
    hm = "cd /nixos-conf/home-configuration/extends/";
    en = "cd /nixos-conf";
    ncg = "nix-collect-garbage";
    wr = "cd ~/Workspace/Rust";
    wgl = "cd ~/Workspace/Golang";
    wp = "cd ~/Workspace/Python";
    wj = "cd ~/Workspace/Java";
    wcl = "cd ~/Workspace/C-lang";
    wh = "cd ~/Workspace/Haskell";
    snb = "cd /nixos-conf && nix flake update && sudo nixos-rebuild switch --flake '.#sigma' -I ./default.nix";
    fu = "fish_update_completions";
    fck = "nix flake update --recreate-lock-file --commit-lock-file";
    nr = "nix repl '<nixpkgs>'";
  };
}
