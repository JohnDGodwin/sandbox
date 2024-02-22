Flash the official image.

set udev and reboot.

    This changes all wifi cards connect to be wlan0

      sudo nano /etc/udev/rules.d/98-custom-wifi.rules

        SUBSYSTEM=="net", KERNEL=="wlan*", ACTION=="add", NAME="wlan0"


    This changes the internal wifi to wlan1

      sudo nano /etc/udev/rules.d/99-custom-wifi.rules

        SUBSYSTEM=="net", ACTION=="add", ATTR{type}=="1", ATTR{address}=="98:03:cf:*:*:*", NAME="wlan1"

reboot

***

Connect to the internet

We're going to rely on NetworkManager.<br>
Enter the following, replacing your_SSID, your_password, and your_interface as needed.

`nmcli connection add ifname wlan1 type wifi ssid Your_SSID`

`nmcli connection edit wifi-wlan1`

	nmcli> goto wifi
	nmcli 802-11-wireless> set mode infrastructure
	nmcli 802-11-wireless> back
	nmcli> goto wifi-sec
	nmcli 802-11-wireless-security> set key-mgmt wpa-psk
	nmcli 802-11-wireless-security> set psk Your_Password
	nmcli 802-11-wireless-security> save
	nmcli 802-11-wireless-security> quit

 ***

 Update the system.

`sudo apt update && sudo apt upgrade`

 ***

 Remove XFCE4

 `sudo apt remove xfce4`

 `sudo apt autoremove`

 ***

graphical environment for gstreamer playback


`sudo apt install --no-install-recommends xorg lightdm-gtk-greeter lightdm openbox`

Then edit	

`sudo nano /etc/lightdm/lightdm.conf`


insert:

	[Seat:*]
	autologin-user=radxa
	xserver-command = X -nocursor

***

Set a a screen resolution and a wallpaper:

`sudo apt install --no-install-recommends libimlib2-dev libx11-dev libxinerama-dev pkg-config make`

`git clone https://github.com/himdel/hsetroot.git`

`cd hsetroot`

`make`

`sudo make install`


Save your desired background image to /home/ubuntu/desktop.png

A script to set the display resolution

`mkdir scripts`

`sudo nano /home/radxa/scripts/setdisplay.sh`


 insert:


    #/bin/bash
    export DISPLAY=:0
    xset s off -dpms

    #set your desired screen resolution here
    MODE=1920x1080


    if [[ $(xrandr | awk '/HDMI-1/ {print $2}') == "connected" ]]; then
	        xrandr --output HDMI-1 --mode $MODE
    fi
    
    exit 0


Then:

`sudo nano /etc/xdg/openbox/autostart`

    bash /home/radxa/scripts/setdisplay.sh
    hsetroot -cover /home/radxa/desktop.png &





 
