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

# Gets the current status of mpd
status="$(pidof mpvpaper)"

socket=/tmp/mpv-socket
if [ -S "$socket" ]; then
    # notify-send "$socket exists."
    button_toggle="$button_pause"
else 
    # notify-send "$socket does not exist."
    button_toggle="$button_play"
fi

# Variable passed to wofi
options="$button_toggle\n$button_stop\n$button_previous\n$button_next\n$button_repeat\n$button_dir"

# Spawn the mpd menu with the "Play / Pause" entry selected by default
chosen="$(echo -e "$options" | $command)"
case $chosen in
    $button_toggle)
        echo 'cycle pause' | socat - /tmp/mpv-socket
        ;;
    $button_stop)
        echo 'stop' | socat - /tmp/mpv-socket
        ;;
    $button_next)
        echo 'playlist-next' | socat - /tmp/mpv-socket
        ;;
    $button_previous)
        echo 'playlist-prev' | socat - /tmp/mpv-socket
        ;;
    $button_repeat)
        # Ativa/desativa o loop no arquivo atual
        # loop_status=$(echo '{ "command": ["get_property", "pause"] }' | socat - /tmp/mpv-socket)
        # echo 'set loop file' | socat - /tmp/mpv-socket
        # echo 'set loop no' | socat - /tmp/mpv-socket
        # echo 'cycle loop-file' | socat - /tmp/mpv-socket
        # notify-send "$(mpc status | tail -n1 | awk -F '   ' '{print $2}')"

        # Verificar se mpvpaperdaemon está rodando
        if [ -s /tmp/mpvpaperdaemon ]; then
            PRG_PID=$(cat /tmp/mpvpaperdaemon)

            if [ -n "$PRG_PID" ]; then
                if [ -s /tmp/mpvpapertimer ]; then
                    TIMER_LOCK=$(cat /tmp/mpvpapertimer)
                    # Terminar a funcao timer do mpvpaperdaemon
                    if [ -n "$TIMER_LOCK" ]; then
                        # Suspender o processo com o PID armazenado em TIMER_LOCK
                        kill -STOP $TIMER_LOCK
                        notify-send "Modo: Loop no arquivo atual"
                    else
                        # Retomar o processo com o PID armazenado em TIMER_LOCK
                        kill -CONT $TIMER_LOCK
                        notify-send "Modo: Resumindo playlist"
                    fi
                fi
            fi
        else
            # Iniciar o mpvpaperdaemon
            mpvpaperdaemon &
            echo $! > /tmp/mpvpaperdaemon  # Armazena o PID do mpvpaperdaemon
            notify-send "mpvpaperdaemon iniciado"
        fi

        ;;
    $button_dir)
        notify-send "À fazer"
        ;;
    *)
        notify-send "Nada selecionado"
        ;;
esac
exit 0
