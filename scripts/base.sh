#!/bin/bash

echo "=== Bootstrap VM"
# Update package list from ubuntu repos
apt-get -y update --fix-missing >/dev/null 2>&1

function install {
    echo Installing $1
    apt-get -y install $1 >/dev/null 2>&1
}

# Install new software from ubuntu repos
install software-properties-common
install git
install gcc 
install python-dev
install python-setuptools 
install curl
install wget
install python-pip
install build-essential
install python-dev
install python-software-properties
install g++
install zlib1g-dev
install zlib1g
install make
install ntp

chmod a+rw -R /opt
chmod u+x /vagrant/scripts/*.sh
