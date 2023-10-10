#!/bin/bash

systemctl enable kubelet

kubeadm config images pull

#kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-cert-extra-sans "149.156.10.*"
kubeadm init --pod-network-cidr=10.244.0.0/16

sudo -i -u ubuntu bash << EOF
mkdir -p /home/ubuntu/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config
kubeadm token create --print-join-command
EOF
