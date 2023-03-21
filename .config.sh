VBoxManage="/c/Program Files/Oracle/VirtualBox/VBoxManage"

function vm-on { 
  "$VBoxManage" startvm "$1" --type headless 
}

function vm-off { 
  "$VBoxManage" controlvm "$1" poweroff 
}

function vm-ssh {
  ssh kube1@"$1"
}
export -f vm-ssh

alias vm-kube1-on="vm-on kube1"
alias vm-kube1-off="vm-off kube1"

alias vm-kube2-on="vm-on kube2"
alias vm-kube2-off="vm-off kube2"
