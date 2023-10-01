resource "openstack_compute_instance_v2" "access" {
  name = "access"
  image_name = openstack_images_image_v2.ubuntu-server.name
  flavor_name = "h2.medium"
  key_pair = "default"
  security_groups = [
    "default"]

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
