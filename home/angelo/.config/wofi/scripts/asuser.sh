#!/usr/bin/env bash

DIR="$HOME/.config"
theme="--style $DIR/wofi/style.css -C $DIR/wofi/colors"
command="wofi $theme -d -b -H 292 -W 492"

# Apps
app1="Shuffle Wallpaper"
app2="Neovim"
app3="Discord"
app4="Steam (BigPicture)"
app5="Youtube Music"

# Options
options="$app1\n$app2\n$app3\n$app4\n$app5"

# Variable passed to wofi
chosen="$(echo -e "$options" | $command -p "Run as $USER")"

case $chosen in
  $app1)
    shuffle_wallpaper;;
  $app2)
    lapce;;
  $app3)
    discord;;
  $app4)
    steam-native -gamepadui;;
  $app5)
    youtube-music;;
esac

