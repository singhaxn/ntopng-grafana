#! /bin/bash

apt update
apt dist-upgrade -y
apt install -y lsb-release gnupg wget net-tools

cd "$( dirname $0 )"

ARCH=$(uname -m)

# Add ntop repository
if [ "$ARCH" == "aarch64" ]; then
    # arm64
    PACKAGE=https://packages.ntop.org/RaspberryPI/apt-ntop.deb
else
    # amd64
    PACKAGE=https://packages.ntop.org/apt-stable/bullseye/all/apt-ntop-stable.deb
fi
wget "$PACKAGE"
dpkg -i "$( basename "$PACKAGE" )"

# Install ntopng
apt update
apt install -y ntopng ntopng-data

apt clean all
