#!/usr/bin/bash

# Use readlink to get the absolute path
DIR=$(readlink -f "$HOME/Pictures/wallpaper/")

# Initialize swww if not running
if ! swww query &> /dev/null; then
    swww-daemon --format xrgb &
    swww query && swww restore
fi

# Get the current wallpaper
CURRENT_WALLPAPER=$(swww query | grep -oP 'image: \K.*')

# If no wallpaper is set, do nothing
if [[ -z "$CURRENT_WALLPAPER" ]]; then
    exit 0
fi
