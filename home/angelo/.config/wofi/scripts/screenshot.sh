#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

DIR="$HOME/.config/"
theme="--style $DIR/wofi/style.css -C $DIR/wofi/colors"
command="wofi $theme -d -b -L 5 -W 35%"
answer_command="wofi $theme -d -b -L 1 -W 35%"

time=`date +%Y-%m-%d-%H-%M-%S`
#geometry=`xrandr | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
dir="`xdg-user-dir PICTURES`/Screenshots"
#dir="$HOME/Pictures/Screenshots"
file="Screenshot_${time}.png"

# Buttons
screen=" Screen"
area=" Area"
window=" Window"
#infive=" In 5 seconds"
intime=" Insert delay"

notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify "$1"
}

# notify and view screenshot
notify_view () {
	if [[ -e "$dir/$file" ]]; then
		notify_user "Screenshot saved."
	else
		notify_user "Screenshot deleted."
	fi
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		notify_user "Taking shot in : $sec"
		sleep 0.95
	done
}

# take shots
shotnow () {
	#cd ${dir} && sleep 0.5 && maim -u -f png | tee "$file" | xclip -selection clipboard -t image/png
	cd ${dir} && sleep 0.1 && grim $file
  notify_view
}

shot5 () {
	countdown '5'
	#sleep 1 && cd ${dir} && maim -u -f png | tee "$file" | xclip -selection clipboard -t image/png
	cd ${dir} && sleep 0.1 && grim $file
  notify_view
}

shot_in () {
  seconds="$(echo "Insert time." | $answer_command -p 'seconds')"
	
  if [[ $seconds == "" ]]; then
    notify_user "Time not specified"
    exit
  elif [[ ! "$seconds" =~ ^[0-9]+$ ]]; then
    notify_user "Not an integer"
    exit
  else  
    countdown $seconds
  fi
  
	cd ${dir} && sleep 0.1 && grim $file
  notify_view
}

shotwin () {
	location=$(hyprctl -j activewindow | jq -r '. | "\(.at)"' | tr -d '[]')
	size=$(hyprctl -j activewindow | jq -r '. | "\(.size)"' | tr -d '[]' | tr , x)
	cd ${dir} && sleep 0.1 && grim -g "$location $size" $file
	notify_view
}

shotarea () {
	cd ${dir} && grim -g "$(slurp)" $file
  notify_view
}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# Variable passed to rofi
options="$screen\n$area\n$window\n$intime"

chosen="$(echo -e "$options" | $command -p "Select mode")"

case $chosen in
    $screen)
		  shotnow;;
    $area)
		  shotarea;;
    $window)
		  shotwin;;
    $intime)
		  shot_in;;
esac

