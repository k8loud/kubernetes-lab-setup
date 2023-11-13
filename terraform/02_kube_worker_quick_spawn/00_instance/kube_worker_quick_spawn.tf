resource "openstack_compute_instance_v2" "kube_worker_quick_spawn_tmp" {
  name = "kube_worker-quick-spawn-tmp"
  image_name = "Ubuntu-Server-22.04-20230914"
  flavor_name = "h2.medium"
  key_pair = "default"

  security_groups = [
    "default"
  ]

  metadata = {
    label = "kube"
  }

  network {
    name = "ii-executor-network"
  }

  user_data = file("../../../scripts/gen/target/super_script_worker_quick_spawn.sh")
}
