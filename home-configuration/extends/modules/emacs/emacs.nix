{ pkgs, ... }: {
  enable = true;

  extraPackages = epkgs:
    with epkgs; [
      magit
      evil
      linum-relative
      auto-complete
      fiplr
      rainbow-delimiters
      free-keys
      base16-theme

      nix-mode
      racer
      rust-mode
      markdown-mode
      haskell-mode
      lua-mode
      go-mode
      purescript-mode
    ];
}
