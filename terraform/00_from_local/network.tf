resource "openstack_networking_network_v2" "ii_executor_network" {
  count          = var.create_network_and_sub_main ? 1 : 0
  name           = "ii-executor-network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "ii-executor-subnet" {
  count           = var.create_network_and_sub_main ? 1 : 0
  cidr            = "192.168.187.0/24"
  dns_nameservers = ["8.8.8.8"]
  enable_dhcp     = true
  gateway_ip      = "192.168.187.1"
  ip_version      = 4
  name            = "ii-executor-subnet"
  network_id      = openstack_networking_network_v2.ii_executor_network[0].id
  region          = "RegionOne"

  allocation_pool {
    start = "192.168.187.2"
    end   = "192.168.187.254"
  }
}

## get already allocated floating IP
data "openstack_networking_floatingip_v2" "access_ip" {
  address = var.access_ip
}

data "openstack_networking_port_v2" "access_port" {
  fixed_ip = openstack_compute_instance_v2.access.access_ip_v4
}

resource "openstack_networking_floatingip_associate_v2" "access_ip_assoc" {
  floating_ip = var.access_ip
  port_id     = data.openstack_networking_port_v2.access_port.id
}
