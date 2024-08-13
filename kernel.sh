#!/bin/bash
set -e
sudo -A apt autoremove --purge -y linux-image* linux-headers*
sudo -A apt install -y -t bookworm-backports linux-headers-amd64 linux-image-amd64