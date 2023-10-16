

## get already allocated floating IP
data "openstack_networking_floatingip_v2" "access-ip" {
  address = var.access_ip
}

##
data "openstack_networking_port_v2" "access-port" {
  fixed_ip = openstack_compute_instance_v2.access.access_ip_v4
}


resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip = var.access_ip
  port_id = data.openstack_networking_port_v2.access-port.id
}
