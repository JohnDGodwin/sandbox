`git clone https://github.com/rockchip-linux/mpp.git --depth=1`

`git clone -b jellyfin-rga --depth=1 https://github.com/nyanmisaka/rk-mirrors.git`

`git clone https://gitlab.freedesktop.org/gstreamer/gstreamer.git --depth=1`

`git clone --branch gstreamer-rockchip --depth=1 https://github.com/JeffyCN/rockchip_mirrors.git`

`sudo apt install cmake pkg-config flex bison ninja-build libudev-dev libdrm-dev libva-dev freeglut3-dev pip`

`pip install meson`



*run ldconfig after each install below*

***

Build MPP

`git clone https://github.com/rockchip-linux/mpp.git`

`cd mpp`

`cmake -B build`

`sudo cmake --build build --target install`

***

Build RGA

`cd rk-mirrors`

`meson setup build --buildtype=release --default-library=shared -Dcpp_args=-fpermissive -Dlibdrm=false -Dlibrga_demo=false`

`sudo ninja -C build install`

***

build gstreamer

`cd gstreamer`

`meson setup build --buildtype=release --default-library=shared`

`meson configure build`

`sudo ninja -C build install`

***

build gstreamer-rockchip

`cd rockchip-mirrors`

`meson setup build --buildtype=release --default-library=shared`

`meson compile -C build`

`cd build`

`sudo ninja install`
