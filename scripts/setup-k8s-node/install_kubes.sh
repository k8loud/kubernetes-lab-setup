#!/bin/bash

sudo apt install curl apt-transport-https -y

curl -fsSL  https://packages.cloud.google.com/apt/doc/apt-key.gpg|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/k8s.gpg
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update -y
sudo apt install wget curl vim git kubelet=1.26.3-00 kubeadm kubectl=1.26.3-00 -y
sudo apt-mark hold kubelet kubeadm kubectl -y

kubectl version --client && kubeadm version
