#!/bin/bash

sudo apt -y install nmap
sudo apt -y install ucspi-tcp

sudo cp /home/ubuntu/kubernetes-lab-setup/configs/push_token_args_listener.service /etc/systemd/system/push_token_args_listener.service
systemctl enable push_token_args_listener.service
