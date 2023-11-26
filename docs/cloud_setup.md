# Cloud setup
## Kubernetes setup
### Before you begin
1. Consider creating `terraform.tfvars` files in every Terraform directory not to pass the variables each time apply is run
2. If you see that an instance has more than one private IP it may indicate that [this error](https://github.com/k8loud/kubernetes-lab-setup/issues/10) has occured. If that is the case run `terraform destroy` and attemp `terraform apply` again
3. If an instance is stuck in BUILDING or ERROR state do the same
4. Usage of one SSH key `default` for all machines is assumed (besides your local machine)
5. If you get a warning `WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!` when connecting via SSH do as the suggestion says: `ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "<ip>"`
6. Ignore `sudo: unable to resolve host <machine-hostname>: Name or service not known` errors

### From your local machine
1. Provide required keys in `configs/keys`
2. Run `generate_pub_keys.sh` in that directory
3. Provide required VM images in `vm_images`
4. Run `generate_scripts.sh` in `scripts/gen`
6. Run `terraform init && terraform apply` in `terraform/00_from_local`
7. Wait until the access machine is up and connect to it via SSH: `ssh -i <path_to_default.pem> -o "StrictHostKeyChecking=no" ubuntu@<access_fip>`

### From the access machine
1. Make sure that in `scripts/gen/constants.sh` there is `BRANCH="origin/master"` (unless you're testing changes from a different branch)
2. Run `generate_scripts.sh` in that directory
3. Run `terraform init && terraform apply` in `terraform/01_from_access`

### From the kube-master machine
1. Copy `~/.kube/config` to your local machine, put in the same path. It will allow remote connection to the Kubernetes cluster

### Back to the local machine
1. Confirm that you're able to use kubectl from your local machine: `kubectl get nodes`
2. Confirm that the command returned a list containing `kube-master` and some `kube-worker-{id}`, their state should be READY; wait some time if it's not

## Setup within Kubernetes cluster
https://github.com/k8loud/microservices-demo/tree/master/deploy/kubernetes/manifests
