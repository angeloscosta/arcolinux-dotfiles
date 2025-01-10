#!/bin/bash

VIDEO_URL="$1"
START_TIME=$(date +%s%N)
mpv --no-config "$VIDEO_URL" &disown
# mpv --no-config --ytdl-format=webm "$VIDEO_URL" &
# mpv --no-config --list-formats "$VIDEO_URL" &
END_TIME=$(date +%s%N)

ELAPSED_TIME=$(( (END_TIME - START_TIME) / 1000000 ))
echo "Tempo de carregamento: $ELAPSED_TIME ms"
