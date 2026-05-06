#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

# map: source (relative to ~/dotfiles) -> target
declare -A links=(
    ["hypr"]="$CONFIG/hypr"
    ["alacritty"]="$CONFIG/alacritty"
    ["dunst"]="$CONFIG/dunst"
    ["rofi"]="$CONFIG/rofi"
    ["waybar"]="$CONFIG/waybar"
    ["wlogout"]="$CONFIG/wlogout"
)

# scripts that go directly into ~
declare -a scripts=(
    brightness.sh
    numlock.sh
    screenshot.sh
    touchpad.sh
    volume.sh
)

link() {
    local src="$1" dst="$2"

    if [[ -L "$dst" ]]; then
        echo "  skip  $dst (already a symlink)"
        return
    fi

    if [[ -e "$dst" ]]; then
        echo "  backup  $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi

    ln -s "$src" "$dst"
    echo "  linked  $src -> $dst"
}

echo "==> Linking config dirs to $CONFIG"
for src_rel in "${!links[@]}"; do
    link "$DOTFILES/$src_rel" "${links[$src_rel]}"
done

echo ""
echo "==> Linking scripts to $CONFIG"
for script in "${scripts[@]}"; do
    link "$DOTFILES/$script" "$CONFIG/$script"
done

echo ""
echo "Done."
