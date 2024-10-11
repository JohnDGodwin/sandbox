<h1>graphical environment for gstreamer playback</h1>


`sudo apt install --no-install-recommends xorg lightdm-gtk-greeter lightdm openbox`

Then edit	

`sudo nano /etc/lightdm/lightdm.conf`


insert:

	[Seat:*]
	autologin-user=radxa
	xserver-command = X -nocursor



***

TODO:
At this point, reboot and you will have to login with a keyboard at least once, but after it will auto login the ubuntu user to an openbox session with no cursor


***



let's set the desktop wallpaper and write some startup scripts

	
`sudo apt install --no-install-recommends libimlib2-dev libx11-dev libxinerama-dev pkg-config make`

`git clone https://github.com/himdel/hsetroot.git`

`cd hsetroot`

`make`

`sudo make install`



Save your desired background image to /config/desktop.png


a script to set the display resolution 


`sudo nano /config/scripts/setdisplay.sh`


 insert:


    #/bin/bash
    
    #set your desired screen resolution here
    MODE=1920x1080
    RATE=60

    export DISPLAY=:0
    xset s off -dpms
    
    if [[ $(xrandr | awk '/HDMI-1/ {print $2}') == "connected" ]]; then
      xrandr --output HDMI-1 --mode $MODE --rate $RATE
    fi
    exit 0



Make the scripts executable with chmod +x.

`sudo chmod +x /config/scripts/setdisplay.sh`


***

`sudo nano /etc/xdg/openbox/autostart`
 
add:	

	bash /config/scripts/setdisplay.sh

	hsetroot -cover /config/desktop.png &


To display the video stream to the screen borderless we do the following.

`sudo nano /etc/xdg/openbox/rc.xml`

locate the line `<keepBorder>yes</keepBorder>` and replace it with `<keepBorder>no</keepBorder>`

then at the end of the file add:

	<applications>
	     <application class="*">
	         <decor>no</decor>
	    </application>
	</applications>


***
