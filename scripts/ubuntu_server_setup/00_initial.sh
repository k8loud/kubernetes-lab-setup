#!/bin/bash 

sudo apt update
sudo apt -y upgrade
sudo apt-get install openssh-server

ssh-keygen -o -b 4096 -t rsa

git clone https://github.com/k8loud/kubernetes-lab-setup.git ~/kubernetes-lab-setup

# Shutdown and change the adapter's settings
