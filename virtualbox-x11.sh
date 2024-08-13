#!/bin/bash
set -e
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-fasttrack main contrib"|
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A tee /etc/apt/sources.list.d/fasttrack.list
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-backports-staging main contrib"|
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A tee -a /etc/apt/sources.list.d/fasttrack.list
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A apt install -y fasttrack-archive-keyring
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A apt update
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A apt install --no-install-recommends -y virtualbox-guest-x11