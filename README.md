# Kubernetes-lab-setup

### Prerequisites
- VirtualBox
- SSH client
- Git BASH (Windows)
- wget
- SSH keys pair

### Install a clean Ubuntu Server VM
[VirtualBox image](https://drive.google.com/drive/folders/1G2dPVc7KuywBpo7x3FYjypA1Iik9VFWG?usp=share_link)\
[ISO](https://ubuntu.com/download/server)

### Run [ubuntu_server_setup.sh](https://github.com/proman3419/Kubernetes-lab-setup/blob/master/ubuntu_server_setup.sh) on the VM
```bash
wget -P /tmp/ https://github.com/proman3419/Kubernetes-lab-setup/blob/master/ubuntu_server_setup.sh && chmod +x /tmp/ubuntu_server_setup.sh && /tmp/ubuntu_server_setup.sh
```

### Shutdown the VM

### Change the adapter's options
![image](https://user-images.githubusercontent.com/29145519/226700209-2f4f55f6-8add-4c75-a296-d5e44a5c4df7.png)

### Download [.config](https://github.com/proman3419/Kubernetes-lab-setup/blob/master/.config.sh) on your physical machine
```bash
wget -P ~ https://github.com/proman3419/Kubernetes-lab-setup/blob/master/.config.sh
```
Adjust the variables section
```bash
VBOX_MANAGE= #path to VboxManage
KUBE1_IP= #IP of the VM (previous step)
...
```

### Add the following lines to your .bashrc
```bash
KUBERNETES_LAB_CONFIG_PATH="~/.config"
source "$KUBERNETES_LAB_CONFIG_PATH"
```
Remember to `source ~/.bashrc` afterwards.

### Start the VM
```bash
vm-kube1-on
```

### Add your physical machine's SSH key to the VM's authorized_keys
```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub kube1@"$KUBE1_IP"
```
From now on you won't be prompted to enter a password when connecting via SSH.

## Resources
[How to Install Ubuntu Server on VirtualBox](https://hibbard.eu/install-ubuntu-virtual-box/)
