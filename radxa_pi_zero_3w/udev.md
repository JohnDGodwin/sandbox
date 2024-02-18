This changes all wifi cards connect to be wlan0

`sudo nano /etc/udev/rules.d/99-custom-wifi.rules`

    SUBSYSTEM=="net", KERNEL=="wlan*", ACTION=="add", NAME="wlan0"

reboot

