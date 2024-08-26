#!/bin/bash
set -e
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/leukipp/cortile/releases|grep browser_download_url|grep linux_amd64.tar.gz|head -n1|cut -d '"' -f4)"
tar -xf cortile*.tar.gz
rm LICENSE README.md
mv cortile cortile-bin
mkdir -p cortile/DEBIAN cortile/usr/bin
mv cortile-bin cortile/usr/bin/cortile
CORTILE_TAG=`echo $(curl -s https://api.github.com/repos/leukipp/cortile/releases|grep tag|head -n1|cut -d '"' -f4|sed 's/https:\/\/github.com\/leukipp\/cortile\/releases\/tag\///g'|sed 's/v//g')`
cat <<EOF |tee cortile/DEBIAN/control
Package: cortile
Version: $CORTILE_TAG
Architecture: amd64
Maintainer: leukipp <leukipp@github.com>
Section: x11
Priority: optional
Homepage: https://github.com/leukipp/cortile
Description:  Linux auto tiling manager with hot corner support for Openbox, Fluxbox, IceWM, Xfwm, KWin, Marco, Muffin, Mutter and other EWMH compliant window managers using the X11 window system. Therefore, this project provides dynamic tiling for XFCE, LXDE, LXQt, KDE and GNOME (Mate, Deepin, Cinnamon, Budgie) based desktop environments.
EOF
dpkg-deb -b cortile .
rm -rf cortile