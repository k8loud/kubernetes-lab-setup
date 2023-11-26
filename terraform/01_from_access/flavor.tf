resource "openstack_compute_flavor_v2" "h2d_slarge" {
  count = var.create_flavor_h2dslarge ? 1 : 0
  name  = "h2d.slarge"
  ram   = "28000"
  vcpus = "8"
  disk  = "100"
}

resource "openstack_compute_flavor_v2" "h2_medium" {
  count = var.create_flavor_h2medium ? 1 : 0
  name  = "h2.medium"
  ram   = "14000"
  vcpus = "4"
  disk  = "30"
}
