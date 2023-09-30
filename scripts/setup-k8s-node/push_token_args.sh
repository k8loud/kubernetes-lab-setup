#!/bin/bash

PUSH_TIMEOUT_S=5

function get_token_args() {
  api_url=$(echo $(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}' && echo "") | cut -c 9-)

  latest_token=$(kubeadm token list | tail -n 1 | awk -F' ' '{print $1}')
  if [[ -z $latest_token ]]; then
    latest_token=$(kubeadm token generate)
  fi

  cert_hash=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')

  token_args="$api_url $latest_token $cert_hash"
}

#function push_to_host() {
#  local ip="$1"
#  local port="$2"
#  local data="$3"
#
#  echo $data | nc -q $PUSH_TIMEOUT_S $ip $port
#}

function main() {
#  echo "Received token args request from $TCPREMOTEIP"
  get_token_args
#  echo "Answering with token args '$token_args'"
  # TCPREMOTEIP is set by tcpserver
#  push_to_host $TCPREMOTEIP $PUSH_PORT $token_args
  echo $token_args
}

main
