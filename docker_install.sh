#!/bin/bash

#get root permissions
echo "$(whoami)"
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"


#install docker
apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
docker run hello-world

#post installation
groupadd docker
usermod -aG docker $USER

#Configure Docker to start on boot
#To automatically start Docker and Containerd on boot for other distros, use the commands below:
# sudo systemctl enable docker.service
# sudo systemctl enable containerd.service

#To disable this behavior, use disable instead.
#sudo systemctl disable docker.service
#sudo systemctl disable containerd.service
