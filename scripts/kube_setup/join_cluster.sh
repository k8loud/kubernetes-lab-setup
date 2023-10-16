#!/bin/bash

PUSH_PORT=9876

# Filter out public networks and networks having more than 256 hosts (performance reasons)
function filter_ip() {
  local ip_mask="$1"
  local ip=$(echo $ip_mask | cut -d '/' -f 1)
  local mask=$(echo $ip_mask | cut -d '/' -f 2)
  local ip_octets
  IFS='.' read -r -a ip_octets <<< "$ip"

  if (( $mask < 24 )); then
    return 1
  fi

  if [ "${ip_octets[0]}" == "10" ]; then
    return 0
  elif [ "${ip_octets[0]}" == "172" ] && (( ${ip_octets[1]} >= 16 && ${ip_octets[1]} <= 31 )); then
    return 0
  elif [ "${ip_octets[0]}" == "192" ] && [ "${ip_octets[1]}" == "168" ]; then
    return 0
  else
    return 1
  fi
}

function push_to_host() {
  local ip="$1"
  local port="$2"
  local data="$3"

  # -q 0 not to block the script
  echo $data | nc -q 0 $ip $port
}

function find_and_ask_master() {
  interfaces=$(ip -o -4 addr show | awk '{print $2}')
  for interface in $interfaces; do
    ip_mask=$(ip -o -4 addr show dev $interface | grep -Eo 'inet ([0-9.]+/[0-9]+)' | cut -d ' ' -f 2)
    echo "Processing $ip_mask ..."
    if filter_ip $ip_mask; then
      echo "... valid"
      host_ips=$(nmap -n -sn $ip_mask -oG - | awk '/Up$/{print $2}')
      for host_ip in $host_ips; do
        token_args=$(push_to_host $host_ip $PUSH_PORT $token_args)
        echo "Poked $host_ip, received '$token_args'"
        if [[ ! -z "$token_args" ]]; then
          return
        fi
      done
    else
      echo "... invalid"
    fi
  done
}

function join_cluster() {
  IFS=' ' read -ra parts <<< "$token_args"

  api_url="${parts[0]}"
  latest_token="${parts[1]}"
  cert_hash="${parts[2]}"

  echo "Running 'kubeadm reset' (reset the worker's kube config)"
  echo "y" | kubeadm reset

  cmd=$(echo "kubeadm join $api_url --token $latest_token --discovery-token-ca-cert-hash sha256:$cert_hash")
  eval $cmd
}

function main() {
  while : ; do
    while : ; do
      find_and_ask_master
      [[ -z "$token_args" ]] || break
    done
    join_cluster
    # The token could've expired
    [[ $? -eq 0 ]] && break
  done

  sudo ip link delete cni0 type bridge
}

main
