{ config, lib, pkgs, ... }:
let
  cfg = config.profiles.development;
in
{
  options.profiles.development = {
    enable = lib.mkEnableOption
      "Shell/programming stuff";
    shell = lib.mkOption {
      default = null;
      type = lib.types.str;
      description = "Which shell to use, fish or zsh at the moment.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      emacs = {
        enable = true;
        extraPackages = ep: [ ep.magit ];
      };

      broot = {
        enable = true;
        enableFishIntegration = true;

        skin = {
          status_normal_fg = "grayscale(18)";
          status_normal_bg = "grayscale(3)";
          status_error_fg = "red";
          status_error_bg = "yellow";
          tree_fg = "red";
          selected_line_bg = "grayscale(7)";
          permissions_fg = "grayscale(12)";
          size_bar_full_bg = "red";
          size_bar_void_bg = "black";
          directory_fg = "lightyellow";
          input_fg = "cyan";
          flag_value_fg = "lightyellow";
          table_border_fg = "red";
          code_fg = "lightyellow";     
      };
    };

      fish =
        if cfg.shell == "fish" then import ./fish { inherit pkgs; } else { };
      zsh = if cfg.shell == "zsh" then import ./zsh { inherit config; } else { };
  };

    xdg.configFile."fish/functions/fish_prompt.fish".text =
      builtins.readFile ./fish_prompt.fish;

    home.packages = with pkgs; [
      cups
      tmate
      tokei
      nmap
      rnix-lsp
      texlive.combined.scheme-basic

      system-config-printer

      wget
      curl
      sudo
      nix-direnv
      pfetch
      neofetch
      htop
      gotop
      playerctl
      pulseaudioFull
      nodejs
      direnv
      wmctrl
    ];

    programs.git = {
      enable = true;

      userName = "ImExtends";
      userEmail = "sharosari@gmail.com";

      ignores =
        [ ".idea/" "/.vscode" "result/" "direnv/" "*.swp" "*.swo" "*~" ];
    };

    programs.command-not-found.enable = true;
    #Have to find a workaround for after.
    /*programs.command-not-found.dbPath = "${fetchTarball { 
      url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
      sha256 = "04fmnr4sdaz7ndvxlk5yd4kihmqbqxpmzsyp9dmqfy5qwr41vv09";
    }/programs.sqlite}";*/
    
  };
}
