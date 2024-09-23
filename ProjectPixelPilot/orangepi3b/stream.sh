#!/bin/bash

SCREEN_MODE=$(</home/ubuntu/scripts/screen-mode)

RUNNING=0
STREAMING=0

GPIO_PIN=17

cd /home/ubuntu/Videos

while true; do
    if [ $(gpio read $GPIO_PIN) -eq 0 ]; then

        if [ $RUNNING -eq 0 ]; then
            kill -15 $STREAMING
            sleep 0.1
            current_date=$(date +'%m-%d-%Y_%H-%M-%S')

                pixelpilot --osd --osd-elements video,wfbng --screen-mode $SCREEN_MODE --dvr-framerate 60 --dvr-fmp4 --dvr record_${current_date}.mp4 &

                RUNNING=$!
        else
                kill -15 $RUNNING
                RUNNING=0
                STREAMING=0
        fi
        sleep 0.1
    elif [ $STREAMING -eq 0 ]; then

        pixelpilot --osd --osd-elements video,wfbng --screen-mode $SCREEN_MODE &

        STREAMING=$!

    fi
    sleep 0.2
done
