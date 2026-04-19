{ config, pkgs, ... }:

{
  home.username = "dog";
  home.homeDirectory = "/home/dog";
  home.stateVersion = "25.11";

  programs.bash = {
    enable = true;
    shellAliases = {
      v = "nvim";
      nrs = "sudo nixos-rebuild switch";
      cat = "bat";
    };

    initExtra = ''
      PS1='\[\e[38;2;122;168;159m\]\u\[\e[38;2;114;113;105m\]@\[\e[38;2;126;156;216m\]\h\[\e[38;2;84;84;109m\] in \[\e[38;2;230;195;132m\]\w\[\e[38;2;118;148;106m\] \$\[\e[0m\] '
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.normal = {
        family = "JetBrains Mono Nerd Font";
        style = "Regular";
      };
      font.size = 16;
    };
    theme = "kanagawa_wave";
  };

  programs.git = {
    enable = true;
    userName = "Parijat";
    userEmail = "parijatbasak06@gmail.com";
  };

  home.file.".config/bat/config".text = ''
    --theme="gruvbox-dark"
    --style="numbers,changes,grid"
    --paging=auto
  '';

  home.file.".config/nvim".source = /home/dog/dotfiles/nvim;

  home.packages = with pkgs; [
    bat
  ];
}
