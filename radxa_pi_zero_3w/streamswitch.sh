#!/bin/bash

RUNNING=0
STREAMING=0

gpio_chip="gpiochip4"
gpio_offset="10"

cd /home/radxa/Videos

export DISPLAY=:0

while true; do
    if [ $(gpioget $gpio_chip $gpio_offset) -eq 0 ]; then

        kill -15 $STREAMING
        sleep 0.1
        
        if [ $RUNNING -eq 0 ]; then
            current_date=$(date +'%m-%d-%Y_%H-%M-%S')

                gst-launch-1.0 -e \
                udpsrc port=5600 caps='application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H265' ! \
                rtph265depay ! \
                h265parse ! \
                tee name=t ! \
                mppvideodec ! \
                rkximagesink plane-id=76 t. ! \
                queue ! \
                mpegtsmux ! \
                filesink location=record_${current_date}.ts &

                RUNNING=$!
        else
                kill -15 $RUNNING
                RUNNING=0
                STREAMING=0
        fi
        sleep 0.1
    elif [ $STREAMING -eq 0 ]; then
    
        gst-launch-1.0 -e \
        udpsrc port=5600 caps='application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H265' ! \
        rtph265depay ! \
        h265parse ! \
        mppvideodec ! \
        rkximagesink plane-id=76 &

        STREAMING=$!
        
    fi
    sleep 0.1
done
