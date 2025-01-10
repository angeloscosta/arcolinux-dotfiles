#!/usr/bin/env bash

wofiDIR="$HOME/.config/wofi"
theme="--style $wofiDIR/style.css -C $wofiDIR/colors"
command="wofi $theme -d -b -L 6 -W 35%"

state="$(hyprctl -j clients)"
options="$(hyprctl -j clients | jq -r '.[] | "\(.workspace.name) \(.class) \(.title)"')"

chosen="$(echo -e "$options" | $command -p "Search")"

if [[ $chosen == "" ]]; then
  exit 0
fi

title="$(echo $chosen | awk -F ' ' '{print $3}')"

hyprctl dispatch focuswindow title:$title
exit 0
