#!/bin/sh

# In use
wallpaperApply=true
gtkApply=true
kittyApply=true
waybarApply=true
hyprApply=true

# Directories
hyprDir="$HOME/.config/hypr"
kittyDir="$HOME/.config/kitty"
waybarDir="$hyprDir/waybar"

wallpaperDay = $HOME/Pictures/Wallpaper/Day
wallpaperNight = $HOME/Pictures/Wallpaper/Night
# wallpaper = $(sed -n 1p $HOME/.config/hypr/custom.conf)

case $1 in
  period-changed)

  notify-send $3

  if [[ $3 == "none" ]]; then

    notify-send "Terminating gammastep."
    exit 0

  elif [[ $3 == "daytime" ]]; then

    # Wallpaper
    if $wallpaperApply; then
      sed -i '1s#.*#/home/angelo/Pictures/Wallpaper/Day/#' $HOME/.config/hypr/custom.conf
      # sed -i '6s#.*#'$wallpaperDay'/#' $HOME/.config/hypr/custom.conf
      /bin/bash $HOME/.config/scripts/changeWallpaper
    fi
    
    # Gtk
    if $gtkApply; then
      cp .config/gsettings/gsettings_ayu .local/share/nwg-look/gsettings
      nwg-look -a
    fi

    # kitty
    if $kittyApply; then
      rm $kittyDir/theme.conf
      ln $kittyDir/kitty-themes/ayu-light.conf $kittyDir/theme.conf
      fi
    
    # waybar
    if $waybarApply; then
      rm $waybarDir/style.css
      ln $waybarDir/themes/ayu-light.css $waybarDir/style.css
    fi

    # hyprApply
    if $hyprApply; then
      rm $hyprDir/custom.conf
      ln $HOME/.config/themes/ayu-light.conf $hyprDir/custom.conf
    fi
      
    notify-send "Theme changed to 'Ayu-Light'"
  elif [[ $3 == "night" ]]; then

    # Wallpaper
    if $wallpaperApply; then
      sed -i '1s#.*#/home/angelo/Pictures/Wallpaper/Night/#' $HOME/.config/hypr/custom.conf
      # sed -i '6s#.*#'$wallpaperNight'/#' $HOME/.config/hypr/custom.conf
      /bin/bash $HOME/.config/scripts/changeWallpaper
    fi
    
    # Gtk
    if $gtkApply; then
      cp .config/gsettings/gsettings_ayu-dark .local/share/nwg-look/gsettings
      nwg-look -a
    fi

    # kitty
    if $kittyApply; then
      rm $kittyDir/theme.conf
      ln $kittyDir/kitty-themes/ayu-dark.conf $kittyDir/theme.conf
    fi
    
    # waybar
    if $waybarApply; then
      rm $waybarDir/style.css
      ln $waybarDir/themes/ayu-dark.css $waybarDir/style.css
    fi

    # hyprApply
    if $hyprApply; then
      rm $hyprDir/custom.conf
      ln $HOME/.config/themes/ayu-dark.conf $hyprDir/custom.conf
    fi
    
      notify-send "Theme changed to 'Ayu-Dark'"
    fi  
  ;;
esac
exit 0
