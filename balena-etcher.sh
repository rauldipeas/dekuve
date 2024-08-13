#!/bin/bash
set -e
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/balena-io/etcher/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
sudo apt install --no-install-recommends -y ./balena-etcher*.deb
rm balena-etcher*.deb