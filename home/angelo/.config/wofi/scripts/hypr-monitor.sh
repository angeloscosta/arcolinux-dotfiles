#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

DIR="$HOME/.config"
images="$HOME/Pictures/Wallpaper/Lockscreen/"

theme="--style $DIR/wofi/lateral.css -C $DIR/wofi/colors"
size="-W 90 -H 466"
layout=$(sed -n 1p $HOME/.config/wofi/lateral_layout)
# command="wofi $theme -d -b -W 90 -l left -x -10 --define halign=center --define hide_search=true "
command="wofi $theme $size $layout -l left -x -10"

monitor="$(hyprctl monitors | head -1 | awk -F ' ' '{print $2}')"

# Orientations
landscape="0"
portrait="90"
landcape_flipped="180"
portrait_flipped="270"

orientation="$landscape\n$portrait\n$landcape_flipped\n$portrait_flipped"

chosen="$(echo -e "$orientation" | $command -p "UP - $uptime")"
case $chosen in
    $landscape)
      hyprctl keyword monitor "eDP-1,transform,0"
    ;;
    $portrait)
      hyprctl keyword monitor "eDP-1,transform,1" 
    ;;
    $landcape_flipped)
      hyprctl keyword monitor "eDP-1,transform,2" 
    ;;
    $portrait_flipped)
      hyprctl keyword monitor "eDP-1,transform,3"
    ;;
esac
exit
