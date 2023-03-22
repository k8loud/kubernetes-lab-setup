#!/bin/bash 

# Enable static IP binding service
# It will be run on startup of the system
sudo cp ~/kubernetes_lab_setup_repo/configs/static_ip_binding.service /etc/systemd/system/static_ip_binding.service
systemctl enable static_ip_binding.service
