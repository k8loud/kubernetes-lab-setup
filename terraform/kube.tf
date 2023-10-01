resource "openstack_compute_instance_v2" "kube_master" {
  name = "kube_master"
  image_name = "Ubuntu-Server-22.04-20230914"
  flavor_name = "h2d.slarge"
  key_pair = "default"
  security_groups = [
    "default"]

  metadata = {
    label = "kube"
  }

  network {
    name = "ii-executor-network"
  }

  user_data = file("../scripts/gen/target/super_script_master.sh")
}


resource "openstack_compute_instance_v2" "kube_worker" {
  name = "kube_worker"
  image_name = "Ubuntu-Server-22.04-20230914"
  flavor_name = "h2.medium"
  key_pair = "default"
  security_groups = [
    "default"]

  metadata = {
    label = "kube"
  }

  network {
    name = "ii-executor-network"
  }

  user_data = file("../scripts/gen/target/super_script_worker.sh")
  count = 1
}

//resource "openstack_networking_floatingip_v2" "fip_1" {
//  pool = "external-10-192"
//}
//
//resource "openstack_compute_floatingip_associate_v2" "fip_1" {
//  floating_ip = openstack_networking_floatingip_v2.fip_1.address
//  instance_id = openstack_compute_instance_v2.kube_master.id
//}

# TODO: conditional spawning from ready images or clean install
