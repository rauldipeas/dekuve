#!/bin/bash
set -e
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A apt install -o Dpkg::Options::="--force-confold" --no-install-recommends --force-yes -y calamares calamares-settings-debian
SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A sed -i 's/pkexec/SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A/g' /usr/bin/install-debian
cat <<EOF | SUDO_ASKPASS="$HOME/sudo_askpass" sudo -A tee /usr/share/applications/install-debian.desktop
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