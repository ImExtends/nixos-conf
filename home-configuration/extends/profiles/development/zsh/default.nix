{ config, ... }: {
  shellAliases = {
    hm = "cd ~/.config/nixpkgs";
    hr = ''
      cd ~/.config/nixpkgs && nix develop -c home-manager switch'';
    l = "ls -lah";
    gst = "git status";
    grm = "git remote";
    gr = "git rm";
    gc = "git commit";
    gph = "git push";
    gd = "git diff";
    gpl = "git pull";
    pipes = "pipes.sh";
    ".." = "cd ../";
    rm = "rm -v";
    ga = "git add";
    ncg = "nix-collect-garbage -d";
    snb = "sudo nixos-rebuild";
  };

  enable = true;
  autocd = true;
  sessionVariables = {
    TERM = "xterm";
    PATH = "/home/extends/.local/bin:$PATH";
    EDITOR = "nvim";
  };
  oh-my-zsh = {
    enable = true;
    theme = "norm_override";
    custom = "$HOME/.config/zsh/custom/";
  };
  dotDir = ".config/zsh";

  /*plugins = [
    {
      name = "zsh-autosuggestions";
      src = inputs.zsh-autosuggestions;
    }
    {
      name = "zsh-completions";
      src = inputs.zsh-completions;
    }
  ];*/
}
