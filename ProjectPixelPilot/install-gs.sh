#!/bin/bash

#This script will setup a radxa zero 3w for OpenIPC

#setting up a few things
#step 1 - change passwd for root to root
#step 2 - edit /etc/ssh/sshd_config to allow for root login via ssh
#step 3 - sudo systemctl enable ssh



#installing the base system

#update and upgrade system
sudo apt update && sudo apt -y upgrade

#install prerequisite programs
sudo apt install -y git cmake

