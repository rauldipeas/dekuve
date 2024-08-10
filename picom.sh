#!/bin/bash
set -e
sudo apt install -y\
    libconfig-dev\
    libdbus-1-dev\
    libegl-dev\
    libev-dev\
    libgl-dev\
    libepoxy-dev\
    libpcre2-dev\
    libpixman-1-dev\
    libx11-xcb-dev\
    libxcb1-dev\
    libxcb-composite0-dev\
    libxcb-damage0-dev\
    libxcb-glx0-dev\
    libxcb-image0-dev\
    libxcb-present-dev\
    libxcb-randr0-dev\
    libxcb-render0-dev\
    libxcb-render-util0-dev\
    libxcb-shape0-dev\
    libxcb-util-dev\
    libxcb-xfixes0-dev\
    libxext-dev\
    meson\
    ninja-build\
    uthash-dev
git clone https://github.com/jonaburg/picom
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
mkdir -p picom/DEBIAN picom/usr/bin
PICOM_TAG=`echo $(curl -s https://api.github.com/repos/yshui/picom/releases|grep tag|grep -v Next|head -n1|cut -d '"' -f4|sed 's/https:\/\/github.com\/yshui\/picom\/releases\/tag\///g'|sed 's/v//g')`
#PICOM_VER=`echo "$(git describe --always --dirty)"-"$(git log -1 --date=short --pretty=format:%cd)"|sed 's/v//g'|sed 's/_/-/g'`
cat <<EOF |tee picom/DEBIAN/control
Package: picom
Version: $PICOM_TAG
Architecture: amd64
Maintainer: Yuxuan Shui <yshuiv7@gmail.com>
Depends: python3, libc6 (>= 2.29), libconfig9, libdbus-1-3 (>= 1.9.14), libev4 (>= 1:4.04), libgl1, libpcre3, libpixman-1-0 (>= 0.25.2), libx11-6, libx11-xcb1 (>= 2:1.6.12), libxcb-composite0, libxcb-damage0, libxcb-glx0, libxcb-image0 (>= 0.2.1), libxcb-present0, libxcb-randr0 (>= 1.10), libxcb-render-util0, libxcb-render0 (>= 1.12), libxcb-shape0, libxcb-sync1, libxcb-xfixes0, libxcb-xinerama0, libxcb1 (>= 1.9.2)
Section: x11
Priority: optional
Homepage: https://github.com/yshui/picom
Description: lightweight compositor for X11
 picom is a compositor for X11, based on xcompmgr. In addition to shadows,
 fading and translucency, picom implements window frame opacity control,
 inactive window transparency, and shadows on argb windows.
 .
 picom is a fork of compton as it seems to have become unmaintained.
EOF
mv build/src/picom picom/usr/bin/picom
cd ..
dpkg-deb -b picom/picom .
rm -rf picom