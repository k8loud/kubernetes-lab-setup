#!/bin/bash

systemctl enable kubelet

kubeadm config images pull

kubeadm init --pod-network-cidr=10.244.0.0/16