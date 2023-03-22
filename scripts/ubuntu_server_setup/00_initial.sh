#!/bin/bash 

sudo apt update
sudo apt -y upgrade
sudo apt-get install openssh-server

ssh-keygen -o -b 4096 -t rsa

echo 'KUBERNETES_LAB_SETUP_REPO_PATH=~/kubernetes_lab_setup_repo' >> ~/.bashrc 

source ~/.bashrc

git clone https://github.com/proman3419/Kubernetes-lab-setup.git ${KUBERNETES_LAB_SETUP_REPO_PATH}

# Shutdown and change the adapter's settings
