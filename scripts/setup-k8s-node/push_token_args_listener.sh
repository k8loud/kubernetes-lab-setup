#!/bin/bash

INC_REQ_PORT=9876
PUSH_TOKEN_ARGS_PATH='/home/kube/kubernetes-lab-setup-repo/scripts/setup-k8s-node/push_token_args.sh'

tcpserver 0 $INC_REQ_PORT $PUSH_TOKEN_ARGS_PATH
