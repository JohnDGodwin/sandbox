###How to build Radxa Zero3 image with RSDK

MUST BE BUILT IN UBUNTU 20.04 (Debian 12 *might* work but I've had the build fail)

```sudo apt-get update
sudo apt-get install git qemu-user-static binfmt-support
sudo apt-get install npm docker.io
sudo usermod -a -G docker $USER```

reboot

```git clone --recurse-submodules https://github.com/RadxaOS-SDK/rsdk.git
cd rsdk
npm install @devcontainers/cli
export PATH="$PWD/src/bin:$PWD/node_modules/.bin:$PATH"
rsdk devcon up
rsdk devcon
rsdk devcon shell
rsdk build radxa-zero3 bullseye cli```

The command `rsdk devcon up` will take some time while the build environment downloads and sets up. Up to 45 minutes depending on your internet speed.
When the image is done, it will be located at `rsdk/out/output.img`


###How to build Radxa Zero3 kernel with BSP

Use same build environment as RSDK. Ubuntu 20.04.

```sudo apt update
sudo apt install -y git qemu-user-static binfmt-support
sudo apt install -y podman podman-docker
sudo touch /etc/containers/nodocker
sudo apt install -y systemd-container```

```git clone --recurse-submodules https://github.com/radxa-repo/bsp.git```

```cd bsp
./bsp linux rk356x --no-build```

To remove Radxa's SoC throttle:

```sudo nano .src/linux/drivers/soc/rockchip/rockchip_opp_select.c```

Remove this, around line 1612ish:

```if (soc_is_rk3566t) {
	if (!strcmp(dev_name(dev), "cpu0")) {
		dev_pm_opp_remove(dev, 1608000000);Add commentMore actions
		dev_pm_opp_remove(dev, 1800000000);
		dev_pm_opp_remove(dev, 1992000000);
	}
	if (!strcmp(dev_name(dev), "fde60000.gpu")) {
		dev_pm_opp_remove(dev, 600000000);
		dev_pm_opp_remove(dev, 700000000);
	}
	if (!strcmp(dev_name(dev), "fdf40000.rkvenc")) {
		dev_pm_opp_remove(dev, 400000000);
	}
}```


To build the kernel:

```./bsp --no-prepare-source linux rk356x -r ruby```

This will make many deb packages, but only 2 are needed. The `linux-headers-` and `linux-image-` .deb file.
Go into the image we built earlier and install the new kernel. Headers first, then image:
```sudo dpkg -i linux-headers-6.1.84-999-rk2410_6.1.84-999_arm64.deb
sudo dpkg -i linux-image-6.1.84-999-rk2410_6.1.84-999_arm64.deb```
