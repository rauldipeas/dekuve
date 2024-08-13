#!/bin/bash
set -e
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A plymouth-set-default-theme dekuve
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A update-initramfs -u