resource "openstack_compute_flavor_v2" "h1-smedium" {
  name  = "h1.smedium"
  ram   = "7000"
  vcpus = "2"
  disk  = "25"
  count = 0 # Don't create on our environment, it's provided by the Openstack administrator; if needed change to 1
}
