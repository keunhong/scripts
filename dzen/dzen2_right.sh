#!/bin/zsh

INTERVAL=1

# function calling intervals in seconds
DATEIVAL=1
GTIMEIVAL=60
MAILIVAL=60
CPUTEMPIVAL=1
WEATHERIVAL=1800
SENSORIVAL=10

DATE_FORMAT='%A, %d.%m.%Y %H:%M:%S'
TIME_ZONE=Asia/Seoul
 
# Date
fdate(){
        date +$DATE_FORMAT
}

# TZ Time
fgtime(){
    print -n $(TZ=$TIME_ZONE date +'%H:%M')
}

# MPD
fmpd(){
    mpc current
}

fweather(){
   python /home/k/bin/dzen/weather.py
}

fsensor(){
    GPUTEMP=`nvidia-settings --query GPUCoreTemp -t`
    CPUTEMP=`sensors | grep temp1 | sed 's/.*: *+//' | sed 's/°C  .*)//g'`

    echo "^fg(#ebac54)CPU:^fg() $CPUTEMP°C, ^fg(#ebac54)GPU:^fg() $GPUTEMP°C"
}

#init data
WEATHERCOUNTER=$WEATHERIVAL
SENSORCOUNTER=$SENSORIVAL

while true; do
    if [ $WEATHERCOUNTER -ge $WEATHERIVAL ]; then
        PWEATHER=$(fweather)
        WEATHERCOUNTER=0
    fi

    if [ $SENSORCOUNTER -ge $SENSORIVAL ]; then
        PSENSOR=$(fsensor)
        SENSORCOUNTER=0
    fi


    echo "^fg(#ebac54)$(fdate)^fg()^p(+50)$PWEATHER^p(+50)$PSENSOR^p(+50)$(fmpd)"


    WEATHERCOUNTER=$((WEATHERCOUNTER+1))
    SENSORCOUNTER=$((SENSORCOUNTER+1))

    sleep $INTERVAL
done
