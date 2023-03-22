# Kubernetes-lab-setup

### Prerequisites
- VirtualBox
- SSH client
- Git BASH (Windows)
- wget
- SSH keys pair

## VM setup
<!-- ### [Ready VirtualBox image (login: kube1, password: kube1)](https://drive.google.com/drive/folders/1G2dPVc7KuywBpo7x3FYjypA1Iik9VFWG?usp=share_link) -->
### Clean install
1. Install a clean Ubuntu Server: [ISO](https://ubuntu.com/download/server)
2. Run [00_initial.sh](https://raw.githubusercontent.com/proman3419/Kubernetes-lab-setup/master/scripts/ubuntu_server_setup/00_initial.sh) on the VM
```bash
wget -P /tmp/ https://raw.githubusercontent.com/proman3419/Kubernetes-lab-setup/master/scripts/ubuntu_server_setup/00_initial.sh
chmod +x /tmp/00_initial.sh
/tmp/00_initial.sh
```
3. Shutdown the VM

### Change the adapter's options
![image](https://user-images.githubusercontent.com/29145519/226700209-2f4f55f6-8add-4c75-a296-d5e44a5c4df7.png)

### Create 2 more VMs using the previous steps
- keep all of them running
- change hostname
```bash
hostnamectl set-hostname <kube$i>
```

### On each VM run [01_after_adapter_setup.sh](https://raw.githubusercontent.com/proman3419/Kubernetes-lab-setup/master/scripts/ubuntu_server_setup/01_after_adapter_setup.sh)
```bash
~/kubernetes_lab_setup_repo/scripts/ubuntu_server_setup/01_after_adapter_setup.sh
```

## Physical machine setup
### Download [.kubernetes_lab_config.sh](https://github.com/proman3419/Kubernetes-lab-setup/blob/master/configs/.kubernetes_lab_config.sh) on your physical machine
```bash
wget -P ~ https://raw.githubusercontent.com/proman3419/Kubernetes-lab-setup/master/configs/.kubernetes_lab_config.sh
```
Adjust the variables section
```bash
VBOX_MANAGE_PATH= #path to VboxManage
KUBE1_IP= #
KUBE2_IP= #
KUBE3_IP= #
```

### Add the following lines to your .bashrc
```bash
KUBERNETES_LAB_CONFIG_PATH="~/.kubernetes_lab_config"
source "$KUBERNETES_LAB_CONFIG_PATH"
```
Remember to `source ~/.bashrc` afterwards.

### Start the VM
```bash
vm-kube1-on
```

### Add your physical machine's SSH key to the VM's authorized_keys
```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub kube1@${KUBE1_IP}
```
From now on you won't be prompted to enter a password when connecting via SSH.

### Closing the VM
```bash
vm-kube1-off
```

## Resources
[How to Install Ubuntu Server on VirtualBox](https://hibbard.eu/install-ubuntu-virtual-box/)
