#!/bin/bash

systemctl enable kubelet

kubeadm config images pull

kubeadm init --pod-network-cidr=172.20.0.0/16 --service-cidr=10.32.0.0/24 --apiserver-cert-extra-sans="149.156.10.151,149.156.10.131,localhost"

sudo -i -u ubuntu bash << EOF
mkdir -p /home/ubuntu/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config
kubeadm token create --print-join-command
EOF
