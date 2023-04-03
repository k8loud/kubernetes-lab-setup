# Kubernetes-lab-setup

## Prerequisites
- VirtualBox
- SSH client
- Git BASH (Windows)
- wget
- SSH keys pair

## VM setup
### Get a clean install of Ubuntu Server
- [Ready VirtualBox image (login: kube1, password: kube1)](https://drive.google.com/drive/folders/1G2dPVc7KuywBpo7x3FYjypA1Iik9VFWG?usp=share_link)
- [Alternative installation from scratch](https://ubuntu.com/download/server)

### Create a snapshot "Clean install"

### Download [00_initial.sh](https://raw.githubusercontent.com/k8loud/Kubernetes-lab-setup/master/scripts/ubuntu_server_setup/00_initial.sh)
```bash
wget -P ~ https://raw.githubusercontent.com/proman3419/Kubernetes-lab-setup/master/scripts/ubuntu_server_setup/00_initial.sh
chmod +x ~/00_initial.sh
```

### Shutdown VM and change the adapter's options
![image](https://user-images.githubusercontent.com/29145519/226700209-2f4f55f6-8add-4c75-a296-d5e44a5c4df7.png)

### Create a snapshot "Pre 00_initial"
It will be useful when setting up another VMs

### Create 2 more VMs
**Make sure the VM's state is up to date with the "Pre 00_initial" snapshot**

![image](https://user-images.githubusercontent.com/29145519/227028228-2d5206c7-7eed-47e4-83c8-a5c7f3e26f8d.png)
![image](https://user-images.githubusercontent.com/29145519/227028319-17612d80-3db4-4e98-915c-ab8700a85531.png)
![image](https://user-images.githubusercontent.com/29145519/227028389-dce21682-b249-408c-abd0-7ed49630224a.png)

From now on all steps will have to be applied to all VMs

### Run [00_initial.sh](https://raw.githubusercontent.com/k8loud/Kubernetes-lab-setup/master/scripts/ubuntu_server_setup/00_initial.sh)
```bash
~/00_initial.sh
```
Shutdown the VM after

### Create a snapshot "00_initial"

### Set up an SSH connection from your physical machine to the VM
This step is optional but worth considering since these VMs don't support copy-paste so it's tedious to type commands by hand.
The setup process is described in [this section](#physical-machine-setup)

### Change hostname
```bash
hostnamectl set-hostname <kube$i>
```

### Run [01_after_adapter_setup.sh](https://raw.githubusercontent.com/k8loud/Kubernetes-lab-setup/master/scripts/ubuntu_server_setup/01_after_adapter_setup.sh)
**Make sure all of the VMs are on before running the script**
```bash
~/kubernetes_lab_setup_repo/scripts/ubuntu_server_setup/01_after_adapter_setup.sh
```

### Change processors amount and RAM on each VM

1. Turn off your VM
2. Go to Settings/System
3. In Processor, change CPU amout to at least 2
4. In Motherboard, change RAM to at least 2GB

### Create a snapshot "01_after_adapter_setup"

## Physical machine setup
### Download [.kubernetes_lab_config.sh](https://raw.githubusercontent.com/k8loud/Kubernetes-lab-setup/master/configs/.kubernetes_lab_config.sh) on your physical machine
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

## Setup kubernetes node

1. Enter scripts/setup-k8s-node directory
2. Make sure all scripts in aforementioned folder are runnable (```chmod +x ./*```)
3. Run ```sudo ./03_big_pp_script.sh```
4. Next steps depend on the node type you want to create
   1. for control-plan 
      1. run ```sudo ./04_init_controll_plane.sh```
      2. run 
         ```
         mkdir -p $HOME/.kube
         sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
         sudo chown $(id -u):$(id -g) $HOME/.kube/config
         ```
  
   2. to join a node to the cluster on a master node run ```kubeadm token create --print-join-command``` and run prompted command with sudo mode in worker node

## Resources
[How to Install Ubuntu Server on VirtualBox](https://hibbard.eu/install-ubuntu-virtual-box/)
