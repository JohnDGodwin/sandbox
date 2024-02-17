Notes:

* DVR uses a timestamp naming scheme down to the second, so while it's highly unlikely, wthout installing a RTC it's possible to overwrite a video file

* Currently playback start/stop is controlled via a push button installed to the gpio header between pins 5 and ground

* WFB-ng comes packaged in your /home/ubuntu directory with installation instructions. You will need to complete this for the system to work.

* The stock system will force your display to 1280x720 mode. If you wish to change this behavior, i.e. display 1920x1080, you can do so in the dvr.sh script found at /home/ubuntu/scripts/dvr.sh
