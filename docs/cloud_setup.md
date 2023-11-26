# Cloud setup
### Before you begin
1. Consider creating `terraform.tfvars` files in every Terraform directory not to pass the variables each time apply is run
2. If you see that an instance has more than one private IP it may indicate that [this error](https://github.com/k8loud/kubernetes-lab-setup/issues/10) has occured. If that is the case run `terraform destroy` and attemp `terraform apply` again

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
