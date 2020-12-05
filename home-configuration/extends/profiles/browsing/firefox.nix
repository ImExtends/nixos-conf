{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      darkreader                                        
      dark-night-mode
      vimium
    ];              
    profiles.extends = {
      name = "Extends";
      settings = {};
      isDefault = true;
    };
  };                             
}  
