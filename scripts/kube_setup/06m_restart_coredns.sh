#!/bin/bash

sudo systemctl stop crio
sudo systemctl start crio
kubectl scale deploy/coredns --replicas=0 -n kube-system
kubectl scale deploy/coredns --replicas=2 -n kube-system
