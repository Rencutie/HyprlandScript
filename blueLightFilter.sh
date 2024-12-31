# Made to be used with a keybind
# Requires hyprshade and uses libnotify for the notification
filter="blue-light-filter"

if [ -z $(hyprshade current) ] ;then
     hyprshade on $filter
     notify-send "$filter activated"
else
     notify-send "Hyprshade deactivated"
     hyprshade off
fi
