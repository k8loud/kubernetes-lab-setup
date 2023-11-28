#!/bin/bash

function get_token_args() {
  api_url=$(echo $(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}' && echo "") | cut -c 9-)

  token=$(kubeadm token create $(kubeadm token generate))

  cert_hash=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')

  token_args="$api_url $token $cert_hash"
}

function main() {
  get_token_args
  echo "$token_args"
}

main
