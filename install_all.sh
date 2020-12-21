#!/usr/bin/env bash

LIB_DIR=./lib

sudo dnf install sqlcipher 'https://raw.githubusercontent.com/rpmsphere/x86_64/master/l/libpthread-stubs-devel-0.2-5.1.x86_64.rpm
' 'https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/l/libuv-devel-1.34.2-1.fc32.x86_64.rpm'

# Targeted Linux distribution is Fedora 33 Workstation
# Tested on  Fedora 33 For x86_64. Kernel 5.8.15-301.fc33.x86_64

# Install Tobii USB Host (mandatory) that handles connections to the tracker:
sudo dpkg -i tobiiusbservice_l64U14_2.1.5-28fd4a.deb

# Install Tobii Engine daemon (recommended) that offers extended functionality
sudo dpkg -i tobii_engine_linux-0.1.6.193_rc-Linux.deb

#Install Tobii Config (recommended) to do screen setup and calibration:
sudo dpkg -i tobii_config_0.1.6.111_amd64.deb

#Install Stream Engine Client library to develop for your eye tracker:
if [[ ! -e "${LIB_DIR}" ]]; then
    mkdir ${LIB_DIR}
    tar -xzvf stream_engine_linux_3.0.4.6031.tar.gz -C ${LIB_DIR}
else
    echo "${LIB_DIR} already exist. Continue..."
fi

sudo mkdir /usr/lib/tobii
sudo cp -pR ${LIB_DIR}/lib/x64/*.so /usr/lib/tobii/
sudo cp ./tobii.conf /etc/ld.so.conf.d/
sudo mkdir /usr/include/tobii
sudo cp -R ${LIB_DIR}/include/tobii/* /usr/include/tobii

echo "DONE :)"

sudo apt install ./Tobii.Pro.Eye.Tracker.Manager.Linux-1.12.1.deb
