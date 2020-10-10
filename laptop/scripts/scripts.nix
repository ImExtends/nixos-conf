{ pkgs, ... }:
let
  scripts = {
    extractScript = with pkgs;
      writeShellScriptBin "extract" ''
         if [ -z $1 ]; then
           >&2 echo "Usage: extract tar.bz2|tar.gz|tar.xz|tar|tbz2|tgz|gz|bz2|zip|Z|7z|xz|exe|cab"
           exit 1
         else 
           for arg in "$@"; do
             if [ -f "$arg" ]; then
               case "$arg" in
                 *.tar.bz2)   ${gnutar}/bin/tar xvjf "$arg" ;;
                 *.tar.gz)    ${gnutar}/bin/tar xvzf "$arg" ;;
                 *.tar.xz)    ${gnutar}/bin/tar xvJf "$arg" ;;
                 *.tar)       ${gnutar}/bin/tar xvf "$arg" ;;
                 *.tbz2)      ${gnutar}/bin/tar xvjf "$arg" ;;
                 *.tgz)       ${gnutar}/bin/tar xvzf "$arg" ;;
                 *.gz)        ${gzip}/bin/gzip -d "$arg" ;;
                 *.bz2)       ${bzip2}/bin/bzip2 -d "$arg" ;;
                 *.rar)       ${unrar}/bin/unrar e "$arg" ;;
                 *.zip)       ${unzip}/bin/unzip "$arg" ;;
                 *.lzma)      ${xz}/bin/lzma --format=lzma --decompress "$arg" ;;
                 *.Z)         ${ncompress}/bin/uncompress "$arg" ;;
                 *.xz)        ${xz}/bin/xz --decompress "$arg" ;;
                 *.exe)       ${cabextract}/bin/cabextract "$arg" ;;
                 *.cab)       ${cabextract}/bin/cabextract "$arg" ;;
                 *) 
                   >2& echo "extract: Unknown format '$arg', exit"
                   exit 1
                 ;;
              esac
            else
              >2& echo "File does not exist"
              exit 1
           fi
          done
        fi
      '';

    fetch-gith = with pkgs;
      writeShellScriptBin "fetch-github" ''
        if [ -z $1 ]; then
          >&2 echo "Usage: fetch-github user/repo"
          exit
        else 
          nix-shell -p nix-prefetch-git --run "nix-prefetch-git git@github.com:$1.git" | nix-shell -p jq --run "jq -r '.sha256'"
        fi
      '';
  };
in
builtins.attrValues scripts
