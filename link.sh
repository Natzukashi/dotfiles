#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

# map: source (relative to ~/dotfiles) -> target
declare -A links=(
    ["niri"]="$CONFIG/niri"
    ["alacritty"]="$CONFIG/alacritty"
    ["fastfetch"]="$CONFIG/fastfetch"
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
echo "Done."
