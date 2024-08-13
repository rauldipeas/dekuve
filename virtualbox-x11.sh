#!/bin/bash
set -e
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-fasttrack main contrib"|
sudo -A tee /etc/apt/sources.list.d/fasttrack.list
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-backports-staging main contrib"|
sudo -A tee -a /etc/apt/sources.list.d/fasttrack.list
sudo -A apt install -y fasttrack-archive-keyring
sudo -A apt update
sudo -A apt install --no-install-recommends -y virtualbox-guest-x11