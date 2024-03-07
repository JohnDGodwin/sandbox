Building MPP, RGA, and ffMPEG from scratch

`sudo apt-get update -qq && sudo apt-get -y install autoconf automake build-essential cmake git-core libass-dev libfreetype6-dev libgnutls28-dev libmp3lame-dev libsdl2-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev meson ninja-build pkg-config texinfo wget yasm zlib1g-dev libunistring-dev libaom-dev libdav1d-dev`

<br>

`sudo apt install nasm libx264-dev libx265-dev libnuma-dev`

<br>



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
	sudo ninja -C rkrga_build install

`sudo nano buildFFMPEG.sh`

	mkdir -p ~/ffmpeg && cd ~/ffmpeg
	git clone --depth=1 https://github.com/nyanmisaka/ffmpeg-rockchip.git ffmpeg
	cd ffmpeg
	./configure --prefix=/usr --enable-gpl --enable-version3 --enable-libdrm --enable-rkmpp --enable-rkrga --enable-libx264 --enable-libx265 --extra-libs="-lpthread" --extra-cflags="-march=native" --enable-gnutls --enable-libass --enable-libfreetype --enable-libmp3lame --enable-libvorbis --enable-nonfree
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


    
