#!/bin/bash

add-apt-repository -y ppa:webupd8team/java >/dev/null 2>&1
apt-get -y update

#install jdk 8
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections 
echo "Installing Jdk 8 - Begin"
apt-get install -y --force-yes oracle-java8-installer >/dev/null 2>&1
apt-get install -y --force-yes oracle-java8-set-default >/dev/null 2>&1
echo "Installing Jdk 8 - Done"
