#!/bin/bash

SSID=$1
PSWD=$2

echo "Connecting to $1 with password $2"
sleep 0.1


nmcli connection add ifname your_interface type wifi ssid $1

nmcli connection edit wifi-wlan1 <<EOF
goto wifi
set mode infrastructure
back
goto wifi-sec
set key-mgmt wpa-psk
set psk $2
save
quit
EOF

exit
