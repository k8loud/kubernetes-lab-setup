resource "openstack_images_image_v2" "ubuntu-server" {
  name             = "Ubuntu-Server-22.04-20230914"
  container_format = "ova"
  disk_format      = "vmdk"
  local_file_path  = "../../vm_images/ubuntu-jammy-22.04-cloudimg.vmdk"
  count            = var.create_image_ubuntu_server ? 1 : 0
}
