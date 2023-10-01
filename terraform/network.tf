//resource "openstack_networking_subnet_v2" "ii-executor-subnet" {
//  cidr            = "192.168.200.0/24"
//  dns_nameservers = ["8.8.8.8"]
//  enable_dhcp     = true
//  gateway_ip      = "192.168.200.1"
//  ip_version      = 4
//  name            = "test"
//  network_id      = "82793ea1-5980-49a5-9c38-a5bd9a19b350"
//  region          = "RegionOne"
//
//  allocation_pool {
//    start = "192.168.187.2"
//    end   = "192.168.187.254"
//  }
//}
