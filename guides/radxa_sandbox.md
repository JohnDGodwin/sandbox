<h1>How to make a custom Radxa Zero 3 img</h1>

<h3>Step 1 - Set up your host system</h3>

  Debian 12 is recommended. QEMU has [bug](https://github.com/docker/buildx/issues/1170#issuecomment-2136084089) with later Ubuntu distros when chrooting into an aarch64 environment.

<h3>Step 2 - Install required packages</h3>

    sudo apt update
    sudo apt install qemu-user-static

<h3>Step 3 - Mount the img file</h3>

    sudo losetup -P /dev/loop0 sandbox.img

    sudo mount /dev/loop0p3 /mnt
    sudo mount /dev/loop0p2 /mnt/boot/efi
    sudo mount /dev/loop0p1 /mnt/config

<h3>Step 4 - Chroot into the img</h3>

    sudo cp /usr/bin/qemu-aarch64-static /mnt/usr/bin

    sudo chroot /mnt qemu-aarch64-static /bin/bash

<h3>Step 5 - Make your changes</h3>

  When done:

      exit

<h3>Step 6 - Clean-up</h3>

    sudo umount --recursive /mnt
    sudo losetup -d /dev/loop0
