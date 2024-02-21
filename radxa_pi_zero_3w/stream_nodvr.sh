  GNU nano 6.2                                                    dvr.sh                                                              #!/bin/bash

export DISPLAY=:0

RUNNING=0

gpio_chip="gpiochip3"
gpio_offset="8"

while true; do
    if [ $(sudo gpioget $gpio_chip $gpio_offset) -eq 1 ]; then
    if [ $RUNNING -eq 0 ]; then
            current_date=$(date +'%m-%d-%Y_%H-%M-%S')

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
