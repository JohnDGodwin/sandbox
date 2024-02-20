Notes:

* There are two DVR scripts. The default will simply increment the file name. The second script uses a timestamp naming scheme and is for use if you install a RTC. Just change the name of the `dvr.sh` script to something like `dvr.sh.old`, then rename the `dvr_rtc.sh` to `dvr.sh`

* Currently playback start/stop is controlled via a push button installed to the gpio header between pins 5 and ground.

* WFB-ng comes preinstalled, but you will need to generate the encryption keys for the system to function properly. Run the wfb_keygen script in your home directory, then move the gs.key to your groundstation's /etc directory and the drone.key to your camera's /etc directory.

* The stock system will force your display to 1920x1080 mode. If you wish to change this behavior, i.e. display 1280x720, you can do so in the dvr.sh script found at /home/ubuntu/scripts/setdisplay.sh

* DVR can be accessed via either at `/home/ubuntu/Videos` or via a media server. Connect your groundstation to your home network and it can be accessed via a web browser at `x.x.x.x:8080` -- replace x.x.x.x with your groundstation's local ip address.
