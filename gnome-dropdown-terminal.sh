wid=$(xdotool search --class dropdown | tail -n1)
if [ -z "$wid" ]; then
    gnome-terminal -e 'conky -c /home/sergio/.conkyrc_ncurses'
    wid=$(xdotool search --class gnome-terminal | tail -n1)
    xdotool set_window --class dropdown "$wid" windowmove "$wid" 0 0 windowsize "$wid" x 50%
    wmctrl -i -r "$wid" -b add,maximized_horz,above
    wmctrl -i -r "$wid" -b add,sticky

else
    if [ -z "$(xdotool search --onlyvisible --class dropdown 2>/dev/null)" ]; then
        xdotool  windowmap "$wid" windowmove "$wid" 0 0  windowsize "$wid" x 50%
        wmctrl -i -r "$wid" -b add,maximized_horz,above
        wmctrl -i -r "$wid" -b add,sticky
    else
        xdotool windowunmap "$wid"
    fi
fi
