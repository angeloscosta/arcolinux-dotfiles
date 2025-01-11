#!/bin/sh

# Themes
colorsDay="$HOME/.config/themes/ayu-light-glass.conf"
colorsNight="$HOME/.config/themes/ayu-dark-glass.conf"
gtkDay="Ayu"
gtkNight="Ayu-Dark"
wallDay="$HOME/Imagens/Wallpaper/Day.m3u"
wallNight="$HOME/Imagens/Wallpaper/Night.m3u"

# In use
colorApply=false
wallApply=true
gtkApply=true
waybarApply=false

# Directories
hyprDir="$HOME/.config/hypr"
waybarDir="$HOME/.config/waybar"

apply() {
  if $colorApply; then
    ln -f $1 $HOME/.config/theme.conf
    # Gerar colors.css
    $HOME/.local/bin/get_theme
    # notify-send "Colors changed to '$(echo $1 | awk -F '/' '{print $(NF)}')'"
  fi

  if $gtkApply; then
    gsettings set org.gnome.desktop.interface gtk-theme $2
  fi

  if $wallApply; then
    $HOME/.local/bin/wallscript $3 &> /dev/null &disown
    $HOME/.local/bin/mpvpaperdaemon &> /dev/null &disown
  fi
}

reload() {
  if $waybarApply; then
    killall -SIGUSR2 waybar
  fi
}

case $1 in
  period-changed)

  if [[ $3 == "daytime" ]]; then
    apply $colorsDay $gtkDay $wallDay

  elif [[ $3 == "night" ]]; then
    apply $colorsNight $gtkNight $wallNight

  # elif [[ $3 == "transition" ]]; then
  #   apply $colorsDay $gtkDay

  elif [[ $3 == "none" ]]; then
    notify-send "gammastep: stoped"
  fi
  reload
  ;;
esac

# Mako
# $HOME/.config/hypr/scripts/notifications

exit 0
