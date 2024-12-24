#!/bin/bash
sudo apt-get --purge remove linux-sound-base alsa-base alsa-utils -y &&
sudo apt-get install linux-sound-base alsa-base alsa-utils -y &&
sudo apt-get install gdm3 ubuntu-desktop -y &&
sudo alsa force-reload
