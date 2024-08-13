#!/bin/bash
set -e
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A apt autoremove --purge -y linux-image* linux-headers*
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A apt install -y -t bookworm-backports linux-headers-amd64 linux-image-amd64