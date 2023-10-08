#!/bin/bash 

# This won't work long time, config in this path will be overriden
# Temporary fix so resolvconf can be downloaded
while : ; do
  echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
  sudo apt update
  echo "Y" | sudo apt -y install resolvconf
  if [ $? -eq 0 ]; then
    break
  fi
done

sudo mkdir -p /etc/resolvconf/resolv.conf.d
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolvconf/resolv.conf.d/head
sudo resolvconf -u

sudo apt update
sudo apt -y upgrade
sudo apt-get -y install openssh-server

ssh-keygen -o -b 4096 -t rsa

git clone https://github.com/k8loud/kubernetes-lab-setup.git /home/ubuntu/kubernetes-lab-setup
git config --global --add safe.directory '*' # fix https://stackoverflow.com/questions/72978485/git-submodule-update-failed-with-fatal-detected-dubious-ownership-in-repositor
chown -R ubuntu:ubuntu /home/ubuntu/kubernetes-lab-setup

touch -p /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh

# TODO: Add .bashrc or sth for storing vars, aliases and functions

# Shutdown and change the adapter's settings
