## get already allocated floating IP
data "openstack_networking_floatingip_v2" "master_ip" {
  address = var.master_ip
}

data "openstack_networking_port_v2" "master_port" {
  fixed_ip = openstack_compute_instance_v2.kube_master.access_ip_v4
}

resource "openstack_networking_floatingip_associate_v2" "master_ip_assoc" {
  floating_ip = var.master_ip
  port_id     = data.openstack_networking_port_v2.master_port.id
}
