#!/bin/bash

swapoff -a

### comment /swap.img in /etc/fstab file
sed -i 's/^\/swap.img/#&/' /etc/fstab

mount -a

### Enable kernel modules
modprobe overlay
modprobe br_netfilter

### Add some settings to sysctl
tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload sysctl
sysctl --system