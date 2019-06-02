#!/usr/bin/env bash

sudo apt update


### BEGIN VirtualBox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib"

sudo apt update
sudo apt install --yes virtualbox virtualbox-ext-pack
### END VirtualBox