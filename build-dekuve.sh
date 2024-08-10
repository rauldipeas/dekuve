#!/bin/bash
set -e
sudo apt install -y debootstrap live-build live-config
sudo rm -rfv /tmp/dekuve
mkdir -p /tmp/dekuve
cd /tmp/dekuve
lb config\
	--apt-indices true\
	--apt-source-archives false\
	--architectures amd64\
	--archive-areas 'main contrib non-free non-free-firmware'\
	--backports true\
	--chroot-squashfs-compression-type xz\
	--color\
	--compression xz\
	--debian-installer live\
	--debian-installer-distribution bookworm\
	--distribution bookworm\
	--distribution-binary bookworm\
	--distribution-chroot bookworm\
	--image-name dekuve\
	--iso-application 'DEKUVE'\
	--iso-publisher 'DEKUVE; https://dekuve.top; contact@dekuve.top'\
	--iso-volume 'DEKUVE'\
	--linux-flavours amd64\
	--mirror-bootstrap 'https://deb.debian.org/debian/'\
	--mirror-chroot 'http://deb.debian.org/debian/'\
	--mirror-binary 'http://deb.debian.org/debian/'\
	--parent-distribution-binary bookworm\
	--quiet\
	--system live\
	--updates true
echo task-xfce-desktop>config/package-lists/desktop.list.chroot
"$(sudo lb build 2>&1|tee /tmp/build-dekuve.log)"