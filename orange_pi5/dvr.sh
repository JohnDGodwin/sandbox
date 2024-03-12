#!/bin/bash

#set your desired recording fps here
framerate=30


export DISPLAY=:0
sudo setcap cap_sys_admin+ep /usr/bin/ffmpeg

RUNNING=0

GPIO_PIN=14

cd /home/orangepi/Videos

while true; do
if [[ $(sudo gpio read $GPIO_PIN) -eq 0 ]]; then
        if [ $RUNNING -eq 0 ]; then
                current_date=$(date +'%m-%d-%Y_%H-%M-%S')

                ffmpeg -framerate $framerate -plane_id 71 -f kmsgrab -i - -c:v hevc_rkmpp rec_${current_date}.mp4 &
                RUNNING=$!
        else
                kill -15 $RUNNING
                RUNNING=0
                sleep 0.5
        fi
        sleep 0.1
fi
sleep 0.1
done
