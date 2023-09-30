#!/bin/bash

sudo apt -y install nmap
sudo apt -y install ucspi-tcp

sudo cp ~/kubernetes-lab-setup-repo/configs/push_token_args_listener.service /etc/systemd/system/push_token_args_listener.service
systemctl enable push_token_args_listener.service
