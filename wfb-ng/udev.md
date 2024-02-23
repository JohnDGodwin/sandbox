This changes all wifi cards connect to be wlan0

`sudo nano /etc/udev/rules.d/98-custom-wifi.rules`

    SUBSYSTEM=="net", KERNEL=="wlan*", ACTION=="add", NAME="wlan0"


This changes the raxda zero 3w internal wifi to wlan1

`sudo nano /etc/udev/rules.d/99-custom-wifi.rules`

    SUBSYSTEM=="net", ACTION=="add", ATTR{type}=="1", ATTR{address}=="98:03:cf:*:*:*", NAME="wlan1"

reboot

