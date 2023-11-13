resource "openstack_compute_flavor_v2" "h2d-slarge" {
  name  = "h2d.slarge"
  ram   = "28000"
  vcpus = "8"
  disk  = "100"
  count = 0 # Don't create on our environment, it's provided by the Openstack administrator; if needed change to 1
}

resource "openstack_compute_flavor_v2" "h2-medium" {
  name  = "h2.medium"
  ram   = "14000"
  vcpus = "4"
  disk  = "30"
  count = 0 # Don't create on our environment, it's provided by the Openstack administrator; if needed change to 1
}
