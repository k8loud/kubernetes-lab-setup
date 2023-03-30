#!/bin/bash

echo "==========================[ Installing kubelet, kubectl, kubeadm ]=========================="
sh ./install_kubes.sh


echo "==========================[ Disable swap space ]=========================="
sh ./disable_swap_space.sh

echo "==========================[ Install CRI-O container runtime ]=========================="
sh ./install_container_runtime.sh