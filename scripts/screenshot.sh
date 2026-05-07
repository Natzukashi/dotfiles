#!/usr/bin/env bash
case "$1" in
output) hyprshot -m output -o ~/Pictures/Screenshots ;;
region) hyprshot -m region -o ~/Pictures/Screenshots ;;
esac
