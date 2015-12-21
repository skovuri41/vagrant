#!/bin/bash
sudo apt-get update
sudo groupadd docker
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker vagrant
sudo service docker restart
sudo systemctl enable docker

