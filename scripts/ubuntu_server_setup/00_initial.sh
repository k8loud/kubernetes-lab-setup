#!/bin/bash 

sudo apt update
sudo apt -y upgrade
sudo apt-get install openssh-server

ssh-keygen -o -b 4096 -t rsa

source ~/.bashrc

git clone https://github.com/proman3419/Kubernetes-lab-setup.git ~/kubernetes_lab_setup_repo

# Shutdown and change the adapter's settings
