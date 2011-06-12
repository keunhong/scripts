#!/bin/bash
if [ "$1" = "main" ]; then
    disper -s
elif [ "$1" = "secondary" ]; then
    disper -S
elif [ "$1" = "extend" ]; then
    disper --displays DFP-2,DFP-0 --extend --direction left
else
    echo "Invalid argument $1"
fi

killall dzen2
xmonad --restart
sleep 2
~/bin/trayer.sh
