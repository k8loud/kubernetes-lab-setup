resource "openstack_compute_instance_v2" "kube_master" {
  name = "kube-master"
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
  depends_on = [openstack_compute_instance_v2.kube_master]
  name = "kube-worker-${count.index}"
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

  user_data = file("../../scripts/gen/target/super_script_worker.sh")
  count = 4
}
