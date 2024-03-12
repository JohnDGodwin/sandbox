#!/bin/bash

export DISPLAY=:0

GPIO_PIN=5
RUNNING=0
sudo gpio mode $GPIO_PIN up

cd /home/ubuntu/Videos

while true; do
if [ $(sudo gpio read $GPIO_PIN) -eq 0 ]; then
if [ $RUNNING -eq 0 ]; then
        current_date=$(date +'%m-%d-%Y_%H-%M-%S')

        gst-launch-1.0 -e \
        udpsrc port=5600 caps='application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H265' ! \
        rtph265depay ! \
        h265parse ! \
        tee name=t ! \
        queue ! \
        mppvideodec ! \
        autovideosink sync=false t. ! \
        queue ! \
        matroskamux ! \
        filesink location=record_${current_date}.mkv &

        RUNNING=$!
else
        kill $RUNNING
        RUNNING=0
        sleep 0.2
        ffmpeg -hwaccel rkmpp -i record_${current_date}.mkv -c:v hevc_rkmpp record_${current_date}.mp4
fi
sleep 0.2
fi
sleep 0.1
