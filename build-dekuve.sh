#!/bin/bash
set -e
wget -q --show-progress http://ftp.us.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2023.3+deb12u1_all.deb
wget -q --show-progress http://ftp.us.debian.org/debian/pool/main/l/live-build/live-build_20230502_all.deb
sudo apt install -y ./debian-archive-keyring*.deb ./live-build*.deb
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
cp desktop-packages.list config/package-lists/desktop.list.chroot
sudo lb build 2>&1|tee /tmp/build-dekuve.log