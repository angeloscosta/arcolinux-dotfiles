import os

def _get_logout():
    desktop = "unknown"
    try:
        out = subprocess.run(
            ["sh", "-c", "env | grep DESKTOP_SESSION"],
            shell=False,
            stdout=subprocess.PIPE,
        )
        desktop = out.stdout.decode().split("=")[1].strip()
        desktop = desktop.lower()
    except Exception as e:
        desktop = "unknown"

    # in case display manager ly is active

    status = os.system("systemctl is-active --quiet ly")
    if status == 0:
        try:
            out = subprocess.run(
                ["sh", "-c", "env | grep XDG_CURRENT_DESKTOP"],
                shell=False,
                stdout=subprocess.PIPE,
            )
            desktop = out.stdout.decode().split("=")[1].strip()
            desktop = desktop.lower()
        except Exception as e:
            desktop = "unknown"

    print("Your desktop is " + desktop)
    if desktop in ("herbstluftwm", "/usr/share/xsessions/herbstluftwm"):
        return "herbstclient quit"
    elif desktop in ("bspwm", "/usr/share/xsessions/bspwm"):
        return "pkill bspwm"
    elif desktop in ("jwm", "/usr/share/xsessions/jwm"):
        return "pkill jwm"
    elif desktop in ("openbox", "/usr/share/xsessions/openbox"):
        return "pkill openbox"
    elif desktop in ("awesome", "/usr/share/xsessions/awesome"):
        return "pkill awesome"
    elif desktop in ("qtile", "/usr/share/xsessions/qtile"):
        return "pkill qtile"
    elif desktop in ("xmonad", "/usr/share/xsessions/xmonad"):
        return "pkill xmonad"
    elif desktop in ("worm", "/usr/share/xsessions/worm"):
        return "pkill worm"
    elif desktop in ("berry", "/usr/share/xsessions/berry"):
        return "pkill berry"
    # for lxdm
    elif desktop in ("Xmonad", "/usr/share/xsessions/xmonad"):
        return "pkill xmonad"
    elif desktop in ("dwm", "/usr/share/xsessions/dwm"):
        return "pkill dwm"
    elif desktop in ("i3", "/usr/share/xsessions/i3"):
        return "pkill i3"
    elif desktop in ("i3-with-shmlog", "/usr/share/xsessions/i3-with-shmlog"):
        return "pkill i3-with-shmlog"
    elif desktop in ("lxqt", "/usr/share/xsessions/lxqt"):
        return "pkill lxqt"
    elif desktop in ("spectrwm", "/usr/share/xsessions/spectrwm"):
        return "pkill spectrwm"
    elif desktop in ("xfce", "/usr/share/xsessions/xfce"):
        return "xfce4-session-logout -f -l"
    elif desktop in ("icewm", "/usr/share/xsessions/icewm"):
        return "pkill icewm"
    elif desktop in ("icewm-session", "/usr/share/xsessions/icewm-session"):
        return "pkill icewm-session"
    elif desktop in ("cwm", "/usr/share/xsessions/cwm"):
        return "pkill cwm"
    elif desktop in ("fvwm3", "/usr/share/xsessions/fvwm3"):
        return "pkill fvwm3"
    elif desktop in ("stumpwm", "/usr/share/xsessions/stumpwm"):
        return "pkill stumpwm"
    elif desktop in ("leftwm", "/usr/share/xsessions/leftwm"):
        return "pkill leftwm"
    elif desktop in ("hypr", "/usr/share/xsessions/hypr"):
        return "pkill Hypr"
    elif desktop in ("dk", "/usr/share/xsessions/dk"):
        return "dkcmd exit"
    elif desktop in ("dusk", "/usr/share/xsessions/dusk"):
        return "pkill dusk"
    elif desktop in ("wmderland", "/usr/share/xsessions/wmderland"):
        return "pkill wmderland"
    elif desktop in ("gnome", "/usr/share/xsessions/gnome"):
        return "gnome-session-quit --logout --no-prompt"
    elif desktop in ("gnome-xorg", "/usr/share/xsessions/gnome-xorg"):
        return "gnome-session-quit --logout --no-prompt"
    elif desktop in ("gnome-classic", "/usr/share/xsessions/gnome-classic"):
        return "gnome-session-quit --logout --no-prompt"
    elif desktop in ("nimdow", "/usr/share/xsessions/nimdow"):
        return "pkill nimdow"

    # wayland desktops
    elif desktop in ("sway", "/usr/share/wayland-sessions/sway"):
        return "pkill sway"
    elif desktop in ("hyprland", "/usr/share/wayland-sessions/hyprland"):
        return "hyprctl dispatch exit"
    elif desktop in ("river", "/usr/share/wayland-sessions/river"):
        return "pkill river"
    elif desktop in ("wayfire", "/usr/share/wayland-sessions/wayfire"):
        return "pkill wayfire"
    elif desktop in ("newm", "/usr/share/wayland-sessions/newm"):
        return "pkill newm"
    elif desktop:
        return "pkill awesome | pkill nimdow| pkill bspwm | pkill cwm |  pkill dwm | pkill dusk | pkill fvwm3 | pkill herbstluftwm | pkill i3 | pkill icewm | pkill jwm | pkill leftwm | pkill lxqt | pkill openbox | pkill qtile | pkill spectrwm | pkill wmderland | pkill xmonad | pkill worm | pkill berry | pkill Hypr | pkill hypr | pkill sway | pkill wayfire | pkill newm | pkill river"
    return None

os.system(_get_logout())
