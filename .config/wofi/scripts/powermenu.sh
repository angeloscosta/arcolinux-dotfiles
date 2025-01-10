#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

DIR="$HOME/.config"
images="$HOME/Pictures/Wallpaper/Lockscreen/"

theme="--style $DIR/wofi/lateral.css -C $DIR/wofi/colors"
size="-W 90 -H 466"
layout=$(sed -n 1p $HOME/.config/wofi/lateral_layout)
command="wofi $theme $size $layout -l right -x -10"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
hybernate=""
suspend=""
lock=""
logout=""

options="$shutdown\n$reboot\n$hybernate\n$suspend\n$lock\n$logout"

chosen="$(echo -e "$options" | $command -p "UP - $uptime")"
case $chosen in
    $shutdown)
      mpc -q stop
      systemctl poweroff
    ;;
    $reboot)
      mpc -q stop
      systemctl reboot
    ;;
    $hybernate)
      mpc -q stop
      systemctl hibernate
    ;;
    $suspend)
      mpc -q stop
      systemctl suspend
    ;;
    $lock)
      mpc -q stop
      loginctl lock-session
    ;;
    $logout)
      mpc -q stop
      # loginctl kill-user $USER
      python3 ~/.local/bin/logout.py
    ;;
esac
exit
