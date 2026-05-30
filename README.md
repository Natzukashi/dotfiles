# My NixOS Dotfiles

Trying out NixOS. It's great, ok, and annoying at the same time. Well, that is Linux for you.

The `nixos` branch is the NixOS stuff and dotfiles. `master` is Hyprland with Arch. You probably want NixOS only, if you are trying it out.

Clone just this repo with:
```bash
git clone https://github.com/Natzukashi/dotfiles --single-branch -b nixos
```

>[!WARNING]
>This repo also has my `hardware-configuration.nix` file. This is unique for every machine. Please do back-up your original `hardware-configuration.nix` as you will need to replace mine with yours.

Very simple configuration.nix with flakes. Follow the official NixOS guide to know what to do.

To apply the configuration, you will need to rebuild the system configuration.

```bash
nixos-rebuild switch --flake ~/nixos#hostname
```

Change your hostname accordingly, of course.
