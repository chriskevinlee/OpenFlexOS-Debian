#!/bin/bash

volume_increase="+10%"
volume_decrease="-10%"

# Function to get the current volume
get_current_volume() {
    pactl list sinks | grep -i 'volume:' | head -n1 | awk '{print $5}'
}

# Check arguments
if [ "$1" = "up" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ "$volume_increase"
    current_volume=$(get_current_volume)
    echo "Current Volume: $current_volume"
    dunstify -r 6534 "Volume Control" "$current_volume"
elif [ "$1" = "down" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ "$volume_decrease"
    current_volume=$(get_current_volume)
    echo "Current Volume: $current_volume"
    dunstify -r 6534 "Volume Control" "$current_volume"
else
    current_volume=$(get_current_volume)
    echo " $current_volume"
fi