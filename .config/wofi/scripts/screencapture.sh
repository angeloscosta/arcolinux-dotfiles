#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

DIR="$HOME/.config/"
theme="--style $DIR/wofi/style.css -C $DIR/wofi/colors"
command="wofi $theme -d -b -L 5 -W 35%"
answer_command="wofi $theme -d -L 1 -W 450"

time=`date +%Y-%m-%d-%H-%M-%S`
#geometry=`xrandr | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
dir="`xdg-user-dir VIDEOS`/Captures"
file="Screencapture_${time}.mp4"

# Buttons
screen=" Screen"
area=" Area"
window=" Window"
infive=" In 5 seconds"
inten=" Insert delay"

notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify "$1"
}

kill_previous_instances() {
  script_name=$(pidof -x "wf-recorder")
  if [[ "$script_name" == "" ]]; then
      echo 0
  else
    for pid in $(pidof -x "wf-recorder"); do
      if [ "$pid" != $$ ]; then
        kill -SIGINT "$pid"
        notify_user "Finished recording"
      fi
    done
    echo 1
  fi
}

# notify and view recorded video
notify_view () {
	#mplayer ${dir}/"$file"
	if [[ -e "$dir/$file" ]]; then
		notify_user "Capture saved."
	else
		notify_user "Failed."
	fi
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		notify_user "Recording in : $sec"
		sleep 0.95
	done
}

# capture
shotnow () {
	cd ${dir} && sleep 0.1 && wf-recorder -f $file
  notify_view
}

shot5 () {
	countdown '5'
	cd ${dir} && sleep 0.1 && wf-recorder -f $file
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

	cd ${dir} && sleep 0.1 && wf-recorder -f $file
  notify_view
}

shotwin () {
	location=$(hyprctl -j activewindow | jq -r '. | "\(.at)"' | tr -d '[]')
	size=$(hyprctl -j activewindow | jq -r '. | "\(.size)"' | tr -d '[]' | tr , x)
	cd ${dir} && sleep 0.1 && wf-recorder -g "$location $size" -f $file
	notify_view
}

shotarea () {
	cd ${dir} && wf-recorder -g "$(slurp)" -f $file
  notify_view
}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

#isopen=$(kill_previous_instances)
if [[ $(kill_previous_instances) == 1 ]]; then
  exit 0
fi

# Variable passed to rofi
options="$screen\n$area\n$window\n$infive\n$inten"

chosen="$(echo -e "$options" | $command -p "Select mode")"

case $chosen in
    $screen)
		  shotnow;;
    $area)
		  shotarea;;
    $window)
		  shotwin;;
    $infive)
		  shot5;;
    $inten)
		  shot_in;;
esac

exit 0

