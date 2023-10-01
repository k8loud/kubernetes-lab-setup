#!/bin/bash

function generate_pub_key() {
  local key="$1"
  local tmp_priv_key="/tmp/$key.pem"
  cp "$key.pem" /tmp && chmod 600 "$tmp_priv_key"
  ssh-keygen -y -f "$tmp_priv_key" > "$key.pub"
  rm "$tmp_priv_key"
}

function main() {
  for priv_key in *.pem; do
    echo $priv_key
    [ -e "$priv_key" ] || continue
    key="${priv_key%.*}"
    key=$(basename $key)
    echo "Generating pub key for $priv_key"
    generate_pub_key "$key"
  done
}

main
