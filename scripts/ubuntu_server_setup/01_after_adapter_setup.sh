#!/bin/bash 

# Enable static IP binding
sudo cp ${KUBERNETES_LAB_SETUP_REPO_PATH}/configs/rc.local /etc/rc.local
sudo cp ${KUBERNETES_LAB_SETUP_REPO_PATH}/configs/rc.local.service /etc/systemd/system/rc-local.service
systemctl enable rc.local
