#!/bin/bash

sudo apt -y install nmap

sudo cp /home/ubuntu/kubernetes-lab-setup/configs/join_cluster.service /etc/systemd/system/join_cluster.service
systemctl enable join_cluster.service
