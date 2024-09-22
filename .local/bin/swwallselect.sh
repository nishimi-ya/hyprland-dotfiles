#!/usr/bin/bash

# Configuration
WALLPAPER_DIR=$(readlink -f "$HOME/Pictures/wallpaper/")
TRANSITION_BEZIER="0.25,0.1,0.25,1.0"
TRANSITION_TYPE="grow"
TRANSITION_DURATION="0.6"
TRANSITION_POS=$(hyprctl cursorpos | grep -E '^[0-9]' || echo "0,0")

# Function to initialize swww if not running
init_swww() {
    if ! swww query &> /dev/null; then
        swww-daemon --format xrgb &
        swww query && swww restore
    fi
}

# Function to set wallpaper
set_wallpaper() {
    local wallpaper="$1"
    swww img "$wallpaper" \
        --transition-bezier "$TRANSITION_BEZIER" \
        --transition-type "$TRANSITION_TYPE" \
        --transition-duration "$TRANSITION_DURATION" \
        --transition-pos "$TRANSITION_POS" \
        --invert-y
}

# Main script
init_swww

# Create array of images in directory
mapfile -t images < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \))

# Use wofi to display image selection menu
selected=$(printf '%s\n' "${images[@]##*/}" | wofi --dmenu -p "Select wallpaper image")

# If user selects an image, set it as wallpaper
if [[ -n $selected ]]; then
    selected_path="$WALLPAPER_DIR/$selected"
    set_wallpaper "$selected_path"
fi
