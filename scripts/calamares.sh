#!/bin/bash
set -e
sudo -A apt install -o Dpkg::Options::="--force-confold" --no-install-recommends --force-yes -y calamares calamares-settings-debian
sudo -A sed -i 's/pkexec/sudo -A/g' /usr/bin/install-debian
cat <<EOF | sudo -A tee /usr/share/applications/install-debian.desktop
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
cat <<EOF |sudo tee /etc/live/config.conf.d/debian-custom.conf>/dev/null
LIVE_HOSTNAME=dekuve
#LIVE_USERNAME=user
LIVE_USER_FULLNAME="DEKUVE Live User"
#LIVE_LOCALES=pt_BR.UTF-8
#LIVE_KEYBOARD_LAYOUTS=br
EOF