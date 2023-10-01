#!/bin/bash

systemctl enable kubelet

kubeadm config images pull

# FIXME: Wildcard doesn't work
#kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-cert-extra-sans "149.156.10.*"
kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubeadm token create --print-join-command
