#!/bin/bash
set -e
sudo -A plymouth-set-default-theme dekuve
sudo -A update-initramfs -u