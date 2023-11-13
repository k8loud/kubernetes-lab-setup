resource "openstack_networking_network_v2" "ii-executor-network" {
  name           = "ii-executor-network"
  admin_state_up = "true"
  count          = 0 # Don't create on our environment, it's provided by the Openstack administrator; if needed change to 1
}

resource "openstack_networking_subnet_v2" "ii-executor-subnet" {
  cidr            = "192.168.187.0/24"
  dns_nameservers = ["8.8.8.8"]
  enable_dhcp     = true
  gateway_ip      = "192.168.187.1"
  ip_version      = 4
  name            = "ii-executor-subnet"
  network_id      = openstack_networking_network_v2.ii-executor-network.id
  region          = "RegionOne"
  count           = 0 # Don't create on our environment, it's provided by the Openstack administrator; if needed change to 1

  allocation_pool {
    start = "192.168.187.2"
    end   = "192.168.187.254"
  }
}
