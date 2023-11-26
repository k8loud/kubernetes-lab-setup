resource "openstack_compute_flavor_v2" "h1_smedium" {
  name  = "h1.smedium"
  ram   = "7000"
  vcpus = "2"
  disk  = "25"
  count = var.create_flavor_h1smedium ? 1 : 0
}
