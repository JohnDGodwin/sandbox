Download dependancies

`sudo apt install dkms python3-all-dev fakeroot`

***

rtl8812au drivers installation


enter the following line-by-line

	sudo bash -c "cat > /etc/modprobe.d/wfb.conf <<EOF
	blacklist 88XXau
	blacklist 8812au
	blacklist rtl8812au
	blacklist rtl88x2bs
	options 88XXau_wfb \
	rtw_tx_pwr_idx_override=20
	EOF"



`git clone https://github.com/svpcom/rtl8812au.git`

`cd rtl8812au/`

`sudo ./dkms-install.sh`


***

rtl8812eu driver installation

`git clone https://github.com/svpcom/rtl8812eu.git`

`cd rtl8812eu`

`sudo ./dkms-install.sh`

***

reboot device 

TODO: or figure out how to load the driver without a full reboot. Try "modprobe 88xxau"


***

WFB-ng installation


find wifi device name using iwconfig and substitute it for $WLAN in the script install

`git clone https://github.com/svpcom/wfb-ng.git`

`cd wfb-ng`

`sudo ./scripts/install_gs.sh $WLAN`


after install:


`sudo systemctl enable wifibroadcast`


then


`sudo nano /etc/wifibroadcast.cfg`


change the channel to match the vtx

change the region from 'BO' to '00' 




Copy drone.key from the wfb-ng directory to the vtx's /etc directory

example using scp, replace x.x.x.x with the camera's ip address

`scp drone.key root@x.x.x.x:/etc`


Make sure gs.key was automatically put in /etc on the VRX side

`ls /etc/gs.key`



***


reboot device again


***

test the connection:

on the groundstation run

 `sudo systemctl enable wifibroadcast@gs`
 
`sudo systemctl start wifibroadcast@gs`

`wfb-cli gs`


Plug in the camera and watch the packets come in, xlost should stay near zero while xrecv should go up


***
