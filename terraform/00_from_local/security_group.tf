resource "openstack_networking_secgroup_v2" "secgroup_default" {
  count       = var.create_secgroup_default ? 1 : 0
  name        = "default"
  description = "Default security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_v4_ingress_ssh" {
  count             = var.create_secgroup_default ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.secgroup_default[0].id
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_v4_ingress_https" {
  count             = var.create_secgroup_default ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.secgroup_default[0].id
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_v4_ingress_kubernetes" {
  count             = var.create_secgroup_default ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.secgroup_default[0].id
  protocol          = "tcp"
  port_range_min    = 6443
  port_range_max    = 6443
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_v4_ingress_general_usecase" {
  count             = var.create_secgroup_default ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.secgroup_default[0].id
  protocol          = "tcp"
  port_range_min    = 2000
  port_range_max    = 7000
}
