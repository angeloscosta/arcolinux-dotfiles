#!/usr/bin/env bash

DIR="$HOME/.config"
theme="--style $DIR/wofi/style.css -C $DIR/wofi/colors"
# command="wofi $theme -d -L 6 -W 35% -H 35%"
command="wofi $theme -d -b -H 35% -W 35% -i"

notify-send "Desktop: $XDG_CURRENT_DESKTOP"
if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
  state="$(hyprctl -j clients)"
  options="$(hyprctl -j clients | jq -r '.[] | "\(.workspace.name) \(.class)"')"
fi

#chosen="$(echo -e "$options" | wofi -p "Run as $USER" -d -b -H 35% -W 35%)"
chosen=$(echo -e "$options" | $command --prompt "Search")

if [[ $chosen == "" ]]; then
  exit 0
fi

#workspace="$(echo "$chosen" | awk -F ' ' '{print $1}')"
window="$(echo $chosen | awk -F ' ' '{print $2}')"

#hyprctl dispatch workspace "$workspace"
hyprctl dispatch focuswindow "$window"
exit 0
