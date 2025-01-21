#!/bin/bash

FPS=60
SIZE=1280x720

sshpass -p '12345' ssh -o StrictHostKeyChecking=no root@10.5.0.10 'sed -i "/video0:/,/video1:/ s/fps: [0-9]*/fps: $FPS/" /etc/majestic.yaml'
sshpass -p '12345' ssh -o StrictHostKeyChecking=no root@10.5.0.10 'sed -i "/video0:/,/video1:/ s/size: [0-9x]*/size: $SIZE/" /etc/majestic.yaml'
sshpass -p '12345' ssh -o StrictHostKeyChecking=no root@10.5.0.10 'reboot'
