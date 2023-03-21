VBOX_MANAGE="/c/Program Files/Oracle/VirtualBox/VBoxManage"
KUBE1_IP="192.168.1.28"

function vm-on { 
  "$VBOX_MANAGE" startvm "$1" --type headless 
}

function vm-off { 
  "$VBOX_MANAGE" controlvm "$1" poweroff 
}

function vm-ssh {
  ssh "$1"@"$2"
}

function vm-kube1-ssh {
  vm-ssh kube1 "$KUBE1_IP"
}

alias vm-kube1-on="vm-on kube1"
alias vm-kube1-off="vm-off kube1"
export -f vm-kube1-ssh
