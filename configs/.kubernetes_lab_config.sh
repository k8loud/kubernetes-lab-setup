VBOX_MANAGE_PATH="/c/Program\ Files/Oracle/VirtualBox/VBoxManage"
KUBE1_IP="192.168.1.28"
KUBE2_IP="192.168.1.31"
KUBE3_IP="192.168.1.32"

alias VBoxManage="$VBOX_MANAGE_PATH"

function vm-on { 
  VBoxManage startvm "$1" --type headless 
}

function vm-off { 
  VBoxManage controlvm "$1" poweroff 
}

function vm-ssh {
  ssh kube@"$1"
}
export -f vm-ssh

function vm-kube1-ssh {
  vm-ssh "$KUBE1_IP"
}
export -f vm-kube1-ssh
alias vm-kube1-on="vm-on kube1"
alias vm-kube1-off="vm-off kube1"

function vm-kube2-ssh {
  vm-ssh "$KUBE2_IP"
}
export -f vm-kube2-ssh
alias vm-kube2-on="vm-on kube2"
alias vm-kube2-off="vm-off kube2"

function vm-kube3-ssh {
  vm-ssh "$KUBE3_IP"
}
export -f vm-kube3-ssh
alias vm-kube3-on="vm-on kube3"
alias vm-kube3-off="vm-off kube3"
