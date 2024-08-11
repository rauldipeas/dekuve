#!/bin/bash
set -e
sudo apt install -o Dpkg::Options::="--force-confold" --no-install-recommends --force-yes -y calamares calamares-settings-debian
cat <<EOF | sudo tee /usr/share/applications/install-debian.desktop
[Desktop Entry]
Type=Application
Version=1.0
Name=Install DEKUVE
GenericName=Calamares Installer
Exec=install-debian
Comment=Calamares — Installer for DEKUVE Live
Keywords=calamares;system;install;debian;installer
Icon=calamares
Terminal=false
Categories=Qt;System;
StartupWMClass=calamares
StartupNotify=True
EOF