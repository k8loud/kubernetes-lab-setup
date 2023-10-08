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

mkdir -p /home/ubuntu/.ssh
ssh-keygen -o -b 4096 -q -t rsa -N '' -f "/home/ubuntu/.ssh/id_rsa" <<<y
chmod 600 /home/ubuntu/.ssh/id_rsa

git clone https://github.com/k8loud/kubernetes-lab-setup.git /home/ubuntu/kubernetes-lab-setup
# https://stackoverflow.com/questions/40425201/aws-ubuntu-git-setup-error-fatal-home-not-set
# https://stackoverflow.com/questions/72978485/git-submodule-update-failed-with-fatal-detected-dubious-ownership-in-repositor
git config --system --add safe.directory '*'
chown -R ubuntu:ubuntu /home/ubuntu/kubernetes-lab-setup

touch /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh

# TODO: Add .bashrc or sth for storing vars, aliases and functions

# Shutdown and change the adapter's settings
