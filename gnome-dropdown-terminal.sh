#!/bin/bash
wid=$(cat /tmp/.terminal-wid)

if [ -z "$wid" ]; then
    gnome-terminal -e 'conky -c /home/sergio/.conkyrc_ncurses'
    wid=$(xdotool search --class gnome-terminal | tail -n1)
    xdotool set_window --class dropdown "$wid" windowmove "$wid" 0 0 windowsize "$wid" x 50%
    wmctrl -i -r "$wid" -b add,maximized_horz,above
    wmctrl -i -r "$wid" -b add,sticky
    xdotool windowactivate "$wid"
    touch /tmp/.terminal-visible
    echo $wid > /tmp/.terminal-wid
else
    if [ -e "/tmp/.terminal-visible" ]; then
        xdotool windowunmap "$wid"
        if [ "$?" -ne 0 ]
        then
            gnome-terminal -e 'conky -c /home/sergio/.conkyrc_ncurses'
            wid=$(xdotool search --class gnome-terminal | tail -n1)
            xdotool set_window --class dropdown "$wid" windowmove "$wid" 0 0 windowsize "$wid" x 50%
            wmctrl -i -r "$wid" -b add,maximized_horz,above
            wmctrl -i -r "$wid" -b add,sticky
            xdotool windowactivate "$wid"
            touch /tmp/.terminal-visible
            echo $wid > /tmp/.terminal-wid
        else
            rm /tmp/.terminal-visible
        fi
    else
        xdotool  windowmap "$wid" windowmove "$wid" 0 0  windowsize "$wid" x 50%
        wmctrl -i -r "$wid" -b add,maximized_horz,above
        wmctrl -i -r "$wid" -b add,sticky
        xdotool windowactivate "$wid"
        touch /tmp/.terminal-visible
    fi
fi
