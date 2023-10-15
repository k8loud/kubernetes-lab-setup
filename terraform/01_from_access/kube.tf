resource "random_string" "worker-suffix" {
  length = var.worker_hostname_suffix_length
}

resource "openstack_compute_instance_v2" "kube_master" {
  name = "kube_master"
  image_name = "Ubuntu-Server-22.04-20230914"
  flavor_name = "h2d.slarge"
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

  user_data = file("../../scripts/gen/target/super_script_master.sh")
}


resource "openstack_compute_instance_v2" "kube_worker" {
  name = "kube_worker-${random_string.worker-suffix}"
  image_name = "Ubuntu-Server-22.04-20230914"
  flavor_name = "h2.medium"
  key_pair = "default"

  # to make sure that master is created first?
#  depends_on = [openstack_compute_instance_v2.kube_master]

  security_groups = [
    "default"
  ]

  metadata = {
    label = "kube"
  }

  network {
    name = "ii-executor-network"
  }

  user_data = file("../../scripts/gen/target/super_script_worker.sh")
  count = 1
}
