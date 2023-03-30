#!/bin/bash

echo "[INFO] Installing kubelet, kubectl, kubeadm"
sh ./install_kubes.sh


echo "[INFO] Disable swap space"
sh ./disable_swap_space.sh

echo "[INFO] Install CRI-O container runtime "
sh ./install_container_runtime.sh