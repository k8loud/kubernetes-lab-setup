#!/bin/bash

INC_REQ_PORT=9876
PUSH_TOKEN_ARGS_PATH='/home/ubuntu/kubernetes-lab-setup/scripts/kube_setup/push_token_args.sh'

tcpserver 0 $INC_REQ_PORT $PUSH_TOKEN_ARGS_PATH
