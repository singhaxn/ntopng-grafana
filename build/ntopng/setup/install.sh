#! /bin/bash

apt update
apt dist-upgrade -y
apt install -y lsb-release gnupg wget net-tools

cd "$( dirname $0 )"

# Add ntop repository
PACKAGE=https://packages.ntop.org/RaspberryPI/apt-ntop.deb
wget "$PACKAGE"
dpkg -i "$( basename "$PACKAGE" )"

# Install ntopng
apt update
apt install -y ntopng ntopng-data

apt clean all
