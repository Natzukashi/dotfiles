{ config, pkgs, ... }:

{
  home.username = "dog";
  home.homeDirectory = "/home/dog";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    floorp-bin
    rofimoji
    nil
    ripgrep
    wlogout
    waybar
    neovim
    kdePackages.dolphin
    rofi
    tree
    dunst
    wiremix
    bluetui
    alacritty
    alsa-utils

    # wlctl
    (rustPlatform.buildRustPackage {
      pname = "wlctl";
      version = "0.1.4";

      src = fetchFromGitHub {
        owner = "aashish-thapa";
        rev = "ac7c05a90c6a2ed811d2245ae632ed3372eeefe7";
        repo = "wlctl";
        sha256 = "sha256-UBcztvI20YGx+tR1z4LQlQijPcQseK7b71LX2UOyALg=";
      };
      cargoHash = "sha256-8LTC5fRdwyXZD8EUz2gR0GTaZuldUTYF/WgAfpMsguM=";
    })
  ];

  programs.hyprshot = {
    enable = true;
    package = pkgs.hyprshot;
    saveLocation = "~/Pictures/Screenshots";
  };

  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "on";
      splash = false;

      preload = [
        "~/dotfiles/config/Wallpapers/cat_vending_machine.png"
      ];

      wallpaper = [ ", ~/dotfiles/config/Wallpapers/cat_vending_machine.png" ];
    };
  };

  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;

    settings = {
      general = {
        lock_cmd = "true";
        before_sleep_cmd = "true";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 240;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      v = "nvim";
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles/$tsuwabuki --impure";
    };
    initExtra = ''
      PS1='\[\e[38;2;122;168;159m\]\u\[\e[38;2;114;113;105m\]@\[\e[38;2;126;156;216m\]\h\[\e[38;2;84;84;109m\] in \[\e[38;2;230;195;132m\]\w\[\e[38;2;118;148;106m\] \$\[\e[0m\] '
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.9;
        padding.x = 6;
        padding.y = 6;
        dynamic_padding = true;
      };
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
    settings = {
      user = {
        name = "Parijat";
        email = "parijatbasak06@gmail.com";
      };
    };
    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/dunst".source = ./config/dunst;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/rofi".source = ./config/rofi;
}
