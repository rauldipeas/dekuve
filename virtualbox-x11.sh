#!/bin/bash
set -e
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-fasttrack main contrib"|
sudo tee /etc/apt/sources.list.d/fasttrack.list
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-backports-staging main contrib"|
sudo tee -a /etc/apt/sources.list.d/fasttrack.list
sudo apt install -y fasttrack-archive-keyring
sudo apt update
sudo apt install --no-install-recommends -y virtualbox-guest-dkms virtualbox-guest-x11