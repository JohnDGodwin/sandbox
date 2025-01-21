#!/bin/bash

FPS=60
SIZE=1280x720

update_fps() {
sshpass -p '12345' ssh -o StrictHostKeyChecking=no root@10.5.0.10 "sed -i \"/video0:/,/video1:/ s/fps: [0-9]*/fps: $FPS/\" /etc/majestic.yaml"
echo "setting camera fps to $FPS"
}

update_size() {
sshpass -p '12345' ssh -o StrictHostKeyChecking=no root@10.5.0.10 "sed -i \"/video0:/,/video1:/ s/size: [0-9x]*/size: $SIZE/\" /etc/majestic.yaml"
echo "setting camera resolution to $SIZE"
}

update_reboot(){
sshpass -p '12345' ssh -o StrictHostKeyChecking=no root@10.5.0.10 'reboot'
echo "rebooting camera..."
}
