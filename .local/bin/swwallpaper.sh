#!/usr/bin/bash

# Use readlink to get the absolute path
DIR=$(readlink -f "$HOME/Pictures/wallpaper/")

# Transition options as variables
TRANSITION_BEZIER="0.25,0.1,0.25,1.0"
TRANSITION_TYPE="grow"
TRANSITION_DURATION="0.4"
TRANSITION_POS=$(hyprctl cursorpos | grep -E '^[0-9]' || echo "0,0")

# Function to get a random picture
get_random_pic() {
    local pics=("$1"/*)
    echo "${pics[RANDOM % ${#pics[@]}]}"
}

# Function to get the next or previous picture
get_next_prev_pic() {
    local direction=$1
    local current_pic=$2
    local pics=("$DIR"/*)
    local index=0
    local num_pics=${#pics[@]}

    # Find the index of the current picture
    for i in "${!pics[@]}"; do
        if [[ "${pics[i]}" = "$current_pic" ]]; then
            index=$i
            break
        fi
    done

    # Calculate the new index based on direction
    if [[ "$direction" == "next" ]]; then
        index=$(( (index + 1) % num_pics ))
    else
        index=$(( (index - 1 + num_pics) % num_pics ))
    fi

    echo "${pics[index]}"
}

# Initialize swww if not running
if ! swww query &> /dev/null; then
    swww-daemon --format xrgb &
    swww query && swww restore
fi

# Get the current wallpaper
CURRENT_WALLPAPER=$(swww query | grep -oP 'image: \K.*')

# Parse command-line options
case "$1" in
    -p|--previous)
        NEWPIC=$(get_next_prev_pic "previous" "$CURRENT_WALLPAPER")
        ;;
    -n|--next)
        NEWPIC=$(get_next_prev_pic "next" "$CURRENT_WALLPAPER")
        ;;
    *)
        NEWPIC=$(get_random_pic "$DIR")
        ;;
esac

# Set the wallpaper using swww
swww img "$NEWPIC" \
    --transition-bezier "$TRANSITION_BEZIER" \
    --transition-type "$TRANSITION_TYPE" \
    --transition-duration "$TRANSITION_DURATION" \
    --transition-pos "$TRANSITION_POS" \
    --invert-y
