### 02_kube_worker_quick_spawn
It's meant to be a VM having the same setup and dependencies as worker but without the 
kube_setup/05w_setup_join_cluster_service.sh service.

When one wants to spawn an instance from the snapshot provide the service setup as user_data

#### Workflow
1. `terraform -chdir=00_instance apply`
2. After cloud-init has finished: `./01_snapshot.sh`
3. `terraform -chdir=00_instance destroy`
4. Optional test: `./02_test_spawn.sh`
