{ pkgs, ... }: {
  enable = true;
  plugins = with pkgs.vimPlugins; [
    vim-polyglot
    vim-one
    nerdtree
    vim-nerdtree-tabs
    gruvbox
    vim-nix
    rust-vim

    coc-nvim
    kotlin-vim
    auto-pairs
    nvim-yarp
    neco-vim
    ncm2
    ncm2-bufword
    ncm2-path
  ];

  extraConfig = ''
    autocmd TermOpen term://* startinsert 

    "Coc extensions
    source /nixos-conf/home-configuration/extends/modules/nvim/coc-extensions.vim
  '' + builtins.readFile ./keybindings.vim;
}
