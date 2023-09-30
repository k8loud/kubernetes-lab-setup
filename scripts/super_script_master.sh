#!/bin/bash

while : ; do
  echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
  sudo apt update
  echo "Y" | sudo apt -y install resolvconf
  if [ $? -eq 0 ]; then
    break
  fi
done

sudo mkdir -p /etc/resolvconf/resolv.conf.d
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolvconf/resolv.conf.d/head
sudo resolvconf -u

sudo apt update
sudo apt -y upgrade
sudo apt-get -y install openssh-server

ssh-keygen -o -b 4096 -t rsa

git clone https://github.com/k8loud/kubernetes-lab-setup.git ~/kubernetes-lab-setup


sudo apt install curl apt-transport-https -y

curl -fsSL  https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/k8s.gpg
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update -y
sudo apt install wget curl vim git kubelet=1.28.2-00 kubeadm kubectl=1.28.2-00 -y
sudo apt-mark hold kubelet kubeadm kubectl -y

kubectl version --client && kubeadm version


### Configure persistent loading of modules
sudo tee /etc/modules-load.d/k8s.conf <<EOF
overlay
br_netfilter
EOF

# Ensure you load modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Set up required sysctl params
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload sysctl
sudo sysctl --system

# Add Cri-o repo
OS="xUbuntu_22.04"
VERSION=1.28
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | apt-key add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | apt-key add -


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

# Install CRI-O
sudo apt update -y
sudo apt install cri-o cri-o-runc -y

# Start and enable Service
sudo systemctl daemon-reload
sudo systemctl restart crio
sudo systemctl enable crio
systemctl status crio

systemctl enable kubelet

kubeadm config images pull

kubeadm init --pod-network-cidr=10.244.0.0/16
# FIXME: Wildcard doesn't work
#kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-cert-extra-sans "149.156.10.*"


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubeadm token create --print-join-command

# TODO: Automate joining cluster (volume, nc or HTTP server)

# TODO: Script generating this script and _worker not to copy paste

# TODO: Possibility to connect to all workers via SSH

echo "=== FINISHED ==="
