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
	--debconf-frontend noninteractive\
	--debian-installer live\
	--debian-installer-distribution bookworm\
	--distribution bookworm\
	--distribution-binary bookworm\
	--distribution-chroot bookworm\
	--image-name dekuve\
	--iso-application 'DEKUVE'\
	--iso-publisher 'DEKUVE; https://dekuve.top; contact@dekuve.top'\
	--iso-volume 'DEKUVE'\
	--mirror-bootstrap 'https://deb.debian.org/debian/'\
	--mirror-chroot 'http://deb.debian.org/debian/'\
	--mirror-binary 'http://deb.debian.org/debian/'\
	--parent-distribution-binary bookworm\
	--quiet\
	--system live\
	--updates true
wget -qO config/hooks/normal/balena-etcher.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/balena-etcher.sh
wget -qO config/hooks/normal/calamares.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/calamares.sh
wget -qO config/hooks/normal/kernel.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/kernel.sh
wget -qO config/hooks/normal/plymouth.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/plymouth.sh
wget -qO config/hooks/normal/virtualbox-x11.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/virtualbox-x11.sh
wget -qO config/package-lists/desktop.list.chroot https://github.com/rauldipeas/dekuve/raw/main/desktop-packages.list
cd config/packages.chroot
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/f3d-app/f3d/releases|grep browser_download_url|grep -v md5|grep -v nightly|grep x86_64.deb|head -n1|cut -d '"' -f4)"
dpkg-name F3D*.deb
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/localsend/localsend/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
dpkg-name LocalSend*.deb
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/JezerM/web-greeter/releases|grep browser_download_url|grep debian.deb|head -n1|cut -d '"' -f4)"
dpkg-name web-greeter*.deb
#wget -q --show-progress https://ppa.launchpadcontent.net/cappelikan/ppa/ubuntu/pool/main/m/mainline/"$(wget -qO- https://ppa.launchpadcontent.net/cappelikan/ppa/ubuntu/pool/main/m/mainline/|grep amd64.deb|tail -n1|cut -d '"' -f8)"
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/bkw777/mainline/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
dpkg-name mainline*.deb
#wget -q --show-progress https://ppa.launchpadcontent.net/xubuntu-dev/extras/ubuntu/pool/main/x/xfce4-docklike-plugin/"$(wget -qO- https://ppa.launchpadcontent.net/xubuntu-dev/extras/ubuntu/pool/main/x/xfce4-docklike-plugin/|grep amd64.deb|tail -n1|cut -d '"' -f8)"
wget -q --show-progress https://mxrepo.com/mx/repo/pool/main/x/xfce4-docklike-plugin/"$(wget -qO- https://mxrepo.com/mx/repo/pool/main/x/xfce4-docklike-plugin/|grep amd64.deb|tail -n1|cut -d '"' -f2)"
dpkg-name xfce4-docklike-plugin*.deb
wget -q --show-progress https://ftp5.gwdg.de/pub/linux/debian/mint/packages/pool/main/w/webapp-manager/"$(wget -qO- https://ftp5.gwdg.de/pub/linux/debian/mint/packages/pool/main/w/webapp-manager/|grep .deb|tail -n1|cut -d '"' -f2)"
dpkg-name webapp-manager*.deb
bash <(wget -qO- https://github.com/rauldipeas/dekuve/raw/main/cortile.sh)
bash <(wget -qO- https://github.com/rauldipeas/dekuve/raw/main/picom.sh)
cd ../..
wget -q --show-progress -O dekuve.zip 'https://www.dropbox.com/scl/fi/erhpzghrhpfcubofnnjdm/dekuve.zip?rlkey=advz5obcky8gm2sekumc3n63v&dl=1'
unzip -q dekuve.zip
rm dekuve.zip
#mv binary/* config/includes.binary/
#rm -rf binary
mv chroot config/includes.chroot
chmod +x config/includes.chroot/usr/local/bin/*
find config/includes.chroot/ -name "*.sh" -exec chmod +x {} \;
sudo lb build 2>&1|tee /tmp/build-dekuve.log