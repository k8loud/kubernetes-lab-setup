# Kubernetes-lab-setup

### Prerequisites
- VirtualBox
- SSH client
- Git BASH (Windows)
- wget
- SSH keys pair

### VM setup
#### [Ready VirtualBox image (login: kube1, password: kube1)](https://drive.google.com/drive/folders/1G2dPVc7KuywBpo7x3FYjypA1Iik9VFWG?usp=share_link)
#### Clean install
1. Install a clean Ubuntu Server: [ISO](https://ubuntu.com/download/server)
2. Run [ubuntu_server_setup.sh](https://github.com/proman3419/Kubernetes-lab-setup/blob/master/ubuntu_server_setup.sh) on the VM
```bash
wget -P /tmp/ https://github.com/proman3419/Kubernetes-lab-setup/blob/master/ubuntu_server_setup.sh && chmod +x /tmp/ubuntu_server_setup.sh && /tmp/ubuntu_server_setup.sh
```
3. Shutdown the VM

### Change the adapter's options
![image](https://user-images.githubusercontent.com/29145519/226700209-2f4f55f6-8add-4c75-a296-d5e44a5c4df7.png)

### Download [.config](https://github.com/proman3419/Kubernetes-lab-setup/blob/master/.config.sh) on your physical machine
```bash
wget -P ~ https://github.com/proman3419/Kubernetes-lab-setup/blob/master/.config.sh
```
Adjust the variables section
```bash
VBOX_MANAGE= #path to VboxManage
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
ssh-copy-id -i ~/.ssh/id_rsa.pub kube1@<kube1_IP>
```
From now on you won't be prompted to enter a password when connecting via SSH.

### Make 2 copies of the VM and the necessary adjustments for each of them:
- generate new SSH keys pair on the VM
```bash
rm ~/.ssh/id_rsa* && ssh-keygen -o -b 4096 -t rsa
```
- add your physical machine's SSH key to the VM's authorized_keys
- change hostname
```bash
hostnamectl set-hostname <kube$i>
```

## Resources
[How to Install Ubuntu Server on VirtualBox](https://hibbard.eu/install-ubuntu-virtual-box/)
