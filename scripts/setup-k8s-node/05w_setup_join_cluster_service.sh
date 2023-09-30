#!/bin/bash

sudo apt -y install nmap

sudo cp ~/kubernetes-lab-setup-repo/configs/join_cluster.service /etc/systemd/system/join_cluster.service
systemctl enable join_cluster.service
