#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

DIR="$HOME/.config/"

theme="--style $DIR/wofi/lateral.css -C $DIR/wofi/colors"
size="-W 90 -H 466"
layout=$(sed -n 1p $HOME/.config/wofi/lateral_layout)
command="wofi $theme $size $layout -l left -x 10"

# Font: Fira Mono
button_music='󰝚'
button_repeat='󰑤'
button_loop='󰑤'
button_shuffle='󰒝'
button_linear='󰒞'
button_error='󰅾'
button_dir='󰉖'
# button_dir='󱧻'

# button_toggle='󰐎'
# button_pause='󰏤'
# button_stop=''
# button_previous='󰓕'
# button_next='󰓗'

button_play=''
button_pause=''
button_toggle=''
button_stop=''
button_previous=''
button_next=''

# button_pause=''
# button_play=''
# button_pause=''
# button_stop=''

# Colors
active=""
urgent=""

# Gets the current status of mpd
status="$(mpc status)"

# Defines the Play / Pause option content
if [[ $status == *"[playing]"* ]]; then
	button_toggle="$button_pause"
else
	button_toggle="$button_play"
fi

# Display if repeat mode is on / off
if [[ $status == *"repeat: on"* ]]; then
    active="-a 4"
elif [[ $status == *"repeat: off"* ]]; then
    urgent="-u 4"
else
    button_repeat="$button_error"
fi

# Display if random mode is on / off
button_random="$button_shuffle"
if [[ $status == *"random: on"* ]]; then
    [ -n "$active" ] && active+=",5" || active="-a 5"
elif [[ $status == *"random: off"* ]]; then
    [ -n "$urgent" ] && urgent+=",5" || urgent="-u 5"
else
    button_random="$button_error"
fi

# Variable passed to rofi
options="$button_toggle\n$button_stop\n$button_previous\n$button_next\n$button_repeat\n$button_random"

# Get the current playing song
current=$(mpc current)
# If mpd isn't running it will return an empty string, we don't want to display that
if [[ -z "$current" ]]; then
    current="None"
fi

# Spawn the mpd menu with the "Play / Pause" entry selected by default
chosen="$(echo -e "$options" | $command)"
case $chosen in
    $button_toggle)
        mpc -q toggle && kunst --size 60x60 --silent
        ;;
    $button_stop)
        mpc -q stop
        ;;
    $button_previous)
        mpc -q prev && kunst --size 60x60 --silent
        ;;
    $button_next)
        mpc -q next && kunst --size 60x60 --silent
        ;;
    $button_repeat)
      mpc -q repeat && notify-send "$(mpc status | tail -n1 | awk -F '   ' '{print $2}')"
        ;;
    $button_random)
      mpc -q random && notify-send "$(mpc status | tail -n1 | awk -F '   ' '{print $3}')"
        ;;
esac
exit 0
