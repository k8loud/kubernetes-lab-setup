resource "openstack_compute_instance_v2" "access" {
  name = "access"
  image_name = "Ubuntu-Server-22.04-20230914"
  flavor_name = "h1.smedium"
  key_pair = "default"
  security_groups = [
    "default"
  ]

  metadata = {
    label = "access"
  }

  network {
    name = "ii-executor-network"
  }

  user_data = file("../../scripts/gen/target/super_script_access.sh")
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "external-10-192"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.fip_1.address
  instance_id = openstack_compute_instance_v2.access.id
}
