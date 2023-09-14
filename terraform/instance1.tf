resource "openstack_compute_instance_v2" "k8s_control_plane" {
  name            = "k8s_control_plane"
  image_id        = "d758624d-e78f-4ff0-88aa-d6bc9c19b19f"
  flavor_name     = "c1.small"
  key_pair        = "h"
  security_groups = ["default"]

  metadata = {
    label = "k8s"
  }

  admin_pass = "kube"

  network {
    name = "ii-executor-network"
  }
}


resource "openstack_compute_instance_v2" "k8s_control_plane_server" {
  name = "k8s_control_plane_our_ubuntu"
  image_id = "ca815a82-63c0-44a2-a499-eb94c7d2bcb9"
  flavor_name = "c1.small"
  key_pair = "h"
  security_groups = ["default"]

  metadata = {
    label = "k8s"
  }

  user_data = file("../scripts/super_script.sh")

  network {
    name = "ii-executor-network"
  }
}