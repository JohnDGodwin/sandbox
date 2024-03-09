#!/bin/bash

export DISPLAY=:0

GPIO_PIN=5
RUNNING=0
sudo gpio mode $GPIO_PIN up

cd /home/orangepi/Videos

sudo setcap cap_sys_admin+ep /usr/bin/ffmpeg

while true; do
if [[ $(sudo gpio read $GPIO_PIN) -eq 0 ]]; then
        if [ $RUNNING -eq 0 ]; then
                current_date=$(date +'%m-%d-%Y_%H-%M-%S')

                ffmpeg -framerate 30 -plane-id x -f kmsgrab -i - -c:v hevc_rkmpp rec_${current_date}.mp4 &

                RUNNING=$!
		else
                kill 15 $RUNNING
                RUNNING=0
		fi
		sleep 0.1
fi
sleep 0.1
