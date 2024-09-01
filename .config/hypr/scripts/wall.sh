#!/bin/bash

# Set directory to wallpaper folder
dir="$HOME/Pictures/wallpaper/"

# Create array of images in directory
images=( $(ls $dir) )

# Use Rofi to display image selection menu
selected=$(printf '%s\n' "${images[@]}" | wofi --dmenu -p "Select wallpaper image")

if [[ $(pidof swaybg) ]]; then
  pkill swaybg
fi

# If user selects an image, run command with selected image as argument
if [[ -n $selected ]]; then
 swaybg -i "$dir/$selected" -m fill
fi

