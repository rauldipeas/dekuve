#!/bin/bash
set -e
cat <<EOF |sudo -A tee /etc/default/grub.d/distributor.cfg
GRUB_DISTRIBUTOR=DEKUVE
EOF