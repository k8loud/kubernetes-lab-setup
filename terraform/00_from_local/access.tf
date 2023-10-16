resource "openstack_compute_instance_v2" "access" {
  name = "access"
  image_name = data.openstack_images_image_v2.ubuntu_server.name
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



