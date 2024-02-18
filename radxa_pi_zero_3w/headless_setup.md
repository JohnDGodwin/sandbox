<h1>Headless Mode -- connection of wifi, setup of autoconnect to your home wifi, and installation of ssh </h1>

<h3>initial connection</h3>

If this is your first boot, you will need to set the root password.

`sudo passwd root`

then as su:

`wpa_passphrase your_SSID your_password > /etc/wpa_supplicant.conf`

`wpa_supplicant -B -i your_interface -c /etc/wpa_supplicant.conf`

`dhclient your_interface`


your_SSID is the name of your wifi network<br> 
your_password is the network's wifi password<br>
your_interface is the name of wifi device. You can find the wifi device name with `ip link`

exit su with `exit`

***

We should now have connection to the internet. Try pinging a website: `ping www.google.com`

Go ahead and perform a `sudo apt update && sudo apt upgrade -y`

***

<h3>Setup of autoconnect on boot</h3>

We're going to rely on NetworkManager.<br>
Enter the following, replacing your_SSID, your_password, and your_interface as needed.

`sudo apt install --no-install-recommends network-manager`

`nmcli connection add ifname your_interface type wifi ssid Your_SSID`

`nmcli connection edit wifi-your_interface`

	nmcli> goto wifi
	nmcli 802-11-wireless> set mode infrastructure
	nmcli 802-11-wireless> back
	nmcli> goto wifi-sec
	nmcli 802-11-wireless-security> set key-mgmt wpa-psk
	nmcli 802-11-wireless-security> set psk Your_Password
	nmcli 802-11-wireless-security> save
	nmcli 802-11-wireless-security> quit

***

<h3>SSH</h3>

	sudo apt install ssh
 	sudo systemctl enable ssh
  	sudo systemctl start ssh

***

Your Radxa pi zero 3w is now headless, ready for an ssh connection on your home wifi network on bootup.
