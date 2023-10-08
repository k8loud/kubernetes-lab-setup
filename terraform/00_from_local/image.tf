resource "openstack_images_image_v2" "ubuntu-server" {
  name             = "Ubuntu-Server-22.04-20230914"
  container_format = "ova"
  disk_format      = "vmdk"
  local_file_path  = "../../vm_images/ubuntu-jammy-22.04-cloudimg.vmdk"
}

# TODO: Move it to a separate module, apply that module first