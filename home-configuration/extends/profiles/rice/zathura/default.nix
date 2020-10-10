{ ... }: {
  enable = true;
  extraConfig = ''
    set recolor
    set completion-bg "#292D3E"
    set completion-fg "#959DCB"
    set completion-group-bg "#292D3E"
    set completion-group-fg "#C3E88D"
    set completion-highlight-bg "#959DCB"
    set completion-highlight-fg "#292D3E"
    set default-bg "#292D3E"
    set recolor-lightcolor "#292D3E"
    set recolor-darkcolor "#959DCB"
    set default-fg "#959DCB"
    set inputbar-bg "#292D3E"
    set inputbar-fg "#959DCB"
    set notification-bg "#292D3E"
    set notification-fg "#959DCB"
    set notification-error-bg "#F07178"
    set notification-error-fg "#959DCB"
    set notification-warning-bg "#F07178"
    set notification-warning-fg "#959DCB"
    set statusbar-bg "#292D3E"
    set statusbar-fg "#959DCB"
    set index-bg "#292D3E"
    set index-fg "#959DCB"
    set index-active-bg "#959DCB"
    set index-active-fg "#292D3E"
    set render-loading-bg "#292D3E"
    set render-loading-fg "#959DCB"

    set window-title-home-tilde true
    set statusbar-basename true
    set selection-clipboard clipboard

    map <C-o> feedkeys ":exec
    ./scripts/zathura-annotate $FILE<Return>"
  '';
}
