#!/bin/bash

export DISPLAY=:0


GPIO_PIN=5
RUNNING=0
sudo gpio mode $GPIO_PIN up


while true; do
if [ $(sudo gpio read $GPIO_PIN) -eq 0 ]; then
if [ $RUNNING -eq 0 ]; then

        gst-launch-1.0 -e \
        udpsrc port=5600 caps='application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H265' ! \
        rtph265depay ! \
        h265parse ! \
        mppvideodec ! \
        videoconvert ! \
        autovideosink sync=false &

        RUNNING=$!
else
        kill $RUNNING
        RUNNING=0

fi
sleep 0.2
fi
sleep 0.1
done
