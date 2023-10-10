#!/bin/bash

function get_token_args() {
  api_url=$(echo $(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}' && echo "") | cut -c 9-)

  latest_token=$(kubeadm token list | tail -n 1 | awk -F' ' '{print $1}')
  if [[ -z $latest_token ]]; then
    latest_token=$(kubeadm token generate)
  fi

  cert_hash=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')

  token_args="$api_url $latest_token $cert_hash"
}

function main() {
  get_token_args
  echo "$token_args"
}

main
