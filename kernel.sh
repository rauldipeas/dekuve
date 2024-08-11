#!/bin/bash
set -e
sudo apt autoremove --purge -y linux-image* linux-headers*
sudo apt install -y -t bookworm-backports linux-image-amd64