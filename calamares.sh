#!/bin/bash
set -e
sudo apt install -o Dpkg::Options::="--force-confold" --no-install-recommends --force-yes -y calamares calamares-settings-debian