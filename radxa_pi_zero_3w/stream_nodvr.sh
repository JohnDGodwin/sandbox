#!/bin/bash

export DISPLAY=:0

gst-launch-1.0 -e \
        udpsrc port=5600 caps='application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H265' ! \
        rtph265depay ! \
        h265parse ! \
        mppvideodec ! \
        videoconvert ! \
        rkximagesink plane-id=76
