#!/bin/bash

shot=`scrot -s '%Y-%m-%d_$wx$h_scrot.png' -e 'mv $f /tmp/%Y-%m-%d_$wx$h_scrot.png; echo /tmp/%Y-%m-%d_$wx$h_scrot.png' 2>&1`
result=`$HOME/bin/share.sh $shot`
rm "$shot"
echo $result
notify-send "Screenshot saved to $result"
echo $result | xclip -selection clipboard
