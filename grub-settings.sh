#!/bin/bash
set -e
cat <<EOF |SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A tee /etc/default/grub.d/distributor.cfg
GRUB_DISTRIBUTOR=DEKUVE
EOF