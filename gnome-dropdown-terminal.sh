wid=$(xdotool search --class dropdown | tail -n1)
#echo $wid
if [ -z "$wid" ]; then
    gnome-terminal -e 'conky -c /home/sergio/.conkyrc_ncurses'
    wid=$(xdotool search --class gnome-terminal | tail -n1)
    xdotool set_window --class dropdown "$wid" windowmove "$wid" 0 0 windowsize "$wid" x 50% #windowactivate "$wid" 
    wmctrl -i -r "$wid" -b add,maximized_horz,above
    wmctrl -i -r "$wid" -b add,sticky

    #xdotool search --sync --onlyvisible --class "gnome-terminal" set_window --class "dropdown" windowmove 0 0 windowsize 1920 50% 
    #xdotool search --sync --onlyvisible --class "dropdown" windowunmap
else
    if [ -z "$(xdotool search --onlyvisible --class dropdown 2>/dev/null)" ]; then
        #echo Mostrar
        xdotool  windowmap "$wid" windowmove "$wid" 0 0  windowsize "$wid" x 50% #windowfocus "$wid" 
        wmctrl -i -r "$wid" -b add,maximized_horz,above
        wmctrl -i -r "$wid" -b add,sticky
    else
        xdotool windowunmap "$wid"
    fi
fi
