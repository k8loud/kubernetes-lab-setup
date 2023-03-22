#!/bin/bash

# Get the network interface's name
INT_NAME=$(ip addr | grep $(hostname -I | awk '{print $1}') | awk '{print $NF}')

# Save the IP/mask given by DHCP
HOST_IP_MASK=$(ip addr | grep $(hostname -I | awk '{print $1}') | awk '{print $2}')

# Save the default's gateway IP
DEFAULT_GATEWAY_IP=$(ip route | grep default | awk '{print $3}')

# Release it
sudo dhclient -r

# Set the data above statically
sudo ip address flush dev ${INT_NAME}
sudo ip route flush dev ${INT_NAME}
sudo ip address add ${HOST_IP_MASK} brd + dev ${INT_NAME}
sudo ip route add ${DEFAULT_GATEWAY_IP} dev ${INT_NAME}
sudo ip route add default via ${DEFAULT_GATEWAY_IP} dev ${INT_NAME}
sudo ip address show dev ${INT_NAME}

echo "Interface name: ${INT_NAME}"
echo "Host IP/mask: ${HOST_IP_MASK}" 
echo "Default gateway IP: ${DEFAULT_GATEWAY_IP}"

# The IP can still be taken when the machine is down
# In such case re-run the script
# If you're planning to set up multiple machines with this script then keep them running to avoid IP addresses' conflicts
