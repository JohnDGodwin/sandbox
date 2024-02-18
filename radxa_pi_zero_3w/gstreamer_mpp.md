Add the repository

`sudo add-apt-repository ppa:liujianfeng1994/rockchip-multimedia`

`sudo apt update`

***

install gstreamer with hardware acceleration

`sudo apt --no-install-recommends install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-gl`

`sudo apt install gstreamer1.0-rockchip1 librga-dev librga2 librockchip-mpp-dev librockchip-mpp1 librockchip-vpu0 libv4l-rkmpp rockchip-multimedia-config`

***

test

`gst-inspect-1.0 | grep 265`

`gst-inspect-1.0 | grep mpp`
