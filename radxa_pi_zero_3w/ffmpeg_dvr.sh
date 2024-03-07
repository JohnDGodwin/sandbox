#!/bin/bash

RUNNING=0

gpio_chip="gpiochip3"
gpio_offset="8"

cd /home/radxa/Videos

export DISPLAY=:0

sudo setcap cap_sys_admin+ep /usr/bin/ffmpeg

while true; do
    if [[ $(sudo gpioget $gpio_chip $gpio_offset) -eq 1 ]]; then
    if [ $RUNNING -eq 0 ]; then
            current_date=$(date +'%m-%d-%Y_%H-%M-%S')

        ffmpeg -framerate 30 -plane_id 76 -f kmsgrab -i - -c:v hevc_rkmpp rec_${current_date}.mp4 &

            RUNNING=$!
    else
            kill 15 $RUNNING
            RUNNING=0
    fi
    sleep 0.1
    fi
    sleep 0.1
done
