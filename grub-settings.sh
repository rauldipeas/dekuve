#!/bin/bash
set -e
cat <<EOF |sudo tee /etc/default/grub.d/distributor.cfg
GRUB_DISTRIBUTOR=DEKUVE
EOF