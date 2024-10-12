#!/bin/bash
set -e
if [ -f "$HOME"/sudo_askpass ];then
	export SUDO_ASKPASS="$HOME/sudo_askpass"
	echo askpass helper enabled
	else
	echo askpass helper skipped
fi
rm -f debian-archive-keyring*.deb live-build*.deb>/dev/null
wget -q --show-progress http://ftp.us.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2023.3+deb12u1_all.deb
wget -q --show-progress http://ftp.us.debian.org/debian/pool/main/l/live-build/live-build_20230502_all.deb
sudo -A apt install -y ./debian-archive-keyring*.deb ./live-build*.deb
sudo -A rm -rf /tmp/dekuve
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
	--debian-installer none\
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
wget -qO config/hooks/normal/balena-etcher.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/scripts/balena-etcher.sh
wget -qO config/hooks/normal/calamares.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/scripts/calamares.sh
wget -qO config/hooks/normal/extra-repositories.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/scripts/extra-repositories.sh
wget -qO config/hooks/normal/flathub.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/scripts/flathub.sh
wget -qO config/hooks/normal/grub-settings.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/scripts/grub-settings.sh
wget -qO config/hooks/normal/kernel.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/scripts/kernel.sh
wget -qO config/hooks/normal/plymouth.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/scripts/plymouth.sh
wget -qO config/hooks/normal/virtualbox-x11.hook.chroot https://github.com/rauldipeas/dekuve/raw/main/scripts/virtualbox-x11.sh
wget -qO config/package-lists/desktop.list.chroot https://github.com/rauldipeas/dekuve/raw/main/scripts/desktop-packages.list
cd config/packages.chroot
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/f3d-app/f3d/releases|grep browser_download_url|grep -v md5|grep -v nightly|grep x86_64.deb|head -n1|cut -d '"' -f4)"
dpkg-name F3D*.deb
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/localsend/localsend/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
dpkg-name LocalSend*.deb
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/JezerM/web-greeter/releases|grep browser_download_url|grep debian.deb|head -n1|cut -d '"' -f4)"
dpkg-name web-greeter*.deb
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/bkw777/mainline/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
dpkg-name mainline*.deb
wget -q --show-progress https://mxrepo.com/mx/repo/pool/main/x/xfce4-docklike-plugin/"$(wget -qO- https://mxrepo.com/mx/repo/pool/main/x/xfce4-docklike-plugin/|grep amd64.deb|tail -n1|cut -d '"' -f2)"
dpkg-name xfce4-docklike-plugin*.deb
wget -q --show-progress http://packages.linuxmint.com/pool/main/w/webapp-manager/"$(wget -qO- http://packages.linuxmint.com/pool/main/w/webapp-manager/|grep .deb|tail -n1|cut -d '"' -f4)"
dpkg-name webapp-manager*.deb
bash <(wget -qO- https://github.com/rauldipeas/dekuve/raw/main/scripts/cortile.sh)
bash <(wget -qO- https://github.com/rauldipeas/dekuve/raw/main/scripts/picom.sh)
cd ../..
wget -q --show-progress -O dekuve.zip 'https://www.dropbox.com/scl/fi/erhpzghrhpfcubofnnjdm/dekuve.zip?rlkey=advz5obcky8gm2sekumc3n63v&dl=1'
unzip -q dekuve.zip
rm dekuve.zip
mv binary/* config/includes.binary/
rm -rf binary
mv chroot config/includes.chroot
chmod +x config/includes.chroot/usr/local/bin/*
find config/includes.chroot/ -name "*.sh" -exec chmod +x {} \;
mkdir -p config/includes/chroot/{usr/local/bin,etc/xdg/autostart,etc/X11/xorg.conf.d,opt/etc}
wget -qO /tmp/dekuve/config/includes/chroot/usr/local/bin/dpcontrol https://github.com/rauldipeas/dekuve/raw/main/assets/dpcontrol/dpcontrol
wget -qO /tmp/dekuve/config/includes/chroot/etc/xdg/autostart/dpcontrol.desktop https://github.com/rauldipeas/dekuve/raw/main/assets/dpcontrol/dpcontrol.desktop
wget -qO /tmp/dekuve/config/includes/chroot/etc/X11/xorg.conf.d/00-touchpad.conf https://github.com/rauldipeas/dekuve/raw/main/assets/touchpad.conf
wget -qO /tmp/dekuve/config/includes/chroot/opt/etc/blur-effect.conf https://github.com/rauldipeas/dekuve/raw/main/assets/blur-effect.conf
sudo -A lb build 2>&1|tee /tmp/build-dekuve.log