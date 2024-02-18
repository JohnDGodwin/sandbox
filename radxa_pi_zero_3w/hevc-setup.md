Building MPP, RGA, Gstreamer, and ffMPEG from scratch

`sudo apt install cmake meson`


`sudo nano buildMPP.sh`

	mkdir -p ~/MPP && cd ~/MPP
	git clone -b jellyfin-mpp --depth=1 https://github.com/nyanmisaka/mpp.git rkmpp
	pushd rkmpp
	mkdir rkmpp_build
	pushd rkmpp_build
	cmake \
	    -DCMAKE_INSTALL_PREFIX=/usr \
	    -DCMAKE_BUILD_TYPE=Release \
	    -DBUILD_SHARED_LIBS=ON \
	    -DBUILD_TEST=OFF \
	    ..
	make -j $(nproc)
	sudo make install
 

`sudo nano buildRGA.sh`

	mkdir -p ~/RGA && cd ~/RGA
	git clone -b jellyfin-rga --depth=1 https://github.com/nyanmisaka/rk-mirrors.git rkrga
	meson setup rkrga rkrga_build \
	    --prefix=/usr \
	    --libdir=lib \
	    --buildtype=release \
	    --default-library=shared \
 	   -Dcpp_args=-fpermissive \
 	   -Dlibdrm=false \
 	   -Dlibrga_demo=false
	meson configure rkrga_build
	sudo ninja -C rkrga_build install

`sudo nano buildFFMPEG.sh`

	mkdir -p ~/ffmpeg && cd ~/ffmpeg
	git clone --depth=1 https://github.com/nyanmisaka/ffmpeg-rockchip.git ffmpeg
	cd ffmpeg
	./configure --prefix=/usr --enable-gpl --enable-version3 --enable-libdrm --enable-rkmpp --enable-rkrga
	make -j $(nproc)

	./ffmpeg -decoders | grep rkmpp
	./ffmpeg -encoders | grep rkmpp
	./ffmpeg -filters | grep rkrga

	sudo make install


Make the scripts executable 

`sudo chmod +x buildMPP.sh buildRGA.sh buildFFMPEG.sh`

And run them one at a time:

`./buildMPP.sh`

`./buildRGA.sh`

`./buildFFMPEG.sh`


gstreamer

`sudo nano buildGSTREAMRROCKCHIP.sh`

    mkdir -p ~/GSTREAMER && cd ~/GSTREAMER
    git clone --branch gstreamer-rockchip https://github.com/JeffyCN/rockchip_mirrors.git
    meson setup build_gsteamer \
      --prefix=/usr \
      --libdir=lib \
      --buildtype=release \
      --default-library=shared
    meson configure build_gstreamer
    sudo ninja -C build_gstreamer install





    
