#!/bin/sh -e
# MongoDB repo keys and repo, both for version 3.0 and 3.2, if you want 3.0 
# just change 3.2 to 3.0
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927 
echo "deb http://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# Update upgrade, burn everything else
apt-get update
apt-get dist-upgrade -y
apt-get autoremove
# Install mongodb, pin the packages just to prevent accidental upgrades
# as recommended in the mongodb documentation
# https://docs.mongodb.org/master/tutorial/install-mongodb-on-ubuntu/#install-the-mongodb-packages
apt-get install -y mongodb-org
# MongoDB documentation also recommends pinning the packages to prevent
# accidental upgrades which shouldn't be an issue because this box isn't
# intended for anything beyond playground
echo "mongodb-org hold" | dpkg --set-selections
echo "mongodb-org-server hold" | dpkg --set-selections
echo "mongodb-org-shell hold" | dpkg --set-selections
echo "mongodb-org-mongos hold" | dpkg --set-selections
echo "mongodb-org-tools hold" | dpkg --set-selections
	
