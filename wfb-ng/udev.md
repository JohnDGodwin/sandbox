This changes all wifi cards connect to be wlan0

`sudo nano /etc/udev/rules.d/98-custom-wifi.rules`

    SUBSYSTEM=="net", KERNEL=="wlan*", ACTION=="add", NAME="wlan0"


This changes the raxda zero 3w internal wifi to wlan1

`sudo nano /etc/udev/rules.d/99-custom-wifi.rules`

    SUBSYSTEM=="net", ACTION=="add", ATTR{type}=="1", ATTR{address}=="98:03:cf:*:*:*", NAME="wlan1"

This dictates up to 4 wifi cards according to thier USB-index or whatever

    SUBSYSTEM=="net", ACTION=="add", ENV{ID_PATH}=="platform-xhci-hcd.3.auto-usb-0:1.1:1.0", NAME="rtl1"
    SUBSYSTEM=="net", ACTION=="add", ENV{ID_PATH}=="platform-xhci-hcd.3.auto-usb-0:1.2:1.0", NAME="rtl2"
    SUBSYSTEM=="net", ACTION=="add", ENV{ID_PATH}=="platform-xhci-hcd.3.auto-usb-0:1.3:1.0", NAME="rtl3"
    SUBSYSTEM=="net", ACTION=="add", ENV{ID_PATH}=="platform-xhci-hcd.3.auto-usb-0:1.4:1.0", NAME="rtl4"

reboot

***

This is for the Orange Pi 3b internal wifi to change to wlan1

`sudo nano /etc/udev/rules.d/99-custom-wifi.rules`

    SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="40:9c:a7:*:*:*", NAME="wlan1"


***
