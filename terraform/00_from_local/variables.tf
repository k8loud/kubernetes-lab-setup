variable "openstack_username" {
  description = "OpenStack username"
  type        = string
  sensitive   = true
}

variable "openstack_password" {
  description = "OpenStack password"
  type        = string
  sensitive   = true
}

variable "create_flavor_h1smedium" {
  description = "Create h1.smedium flavor (for access VM)"
  type        = bool
  default     = true
}

variable "create_image_ubuntu_server" {
  description = "Create Ubuntu Server image (for all VMs)"
  type        = bool
  default     = true
}

variable "create_network_and_sub_main" {
  description = "Create the main network and subnetwork"
  type        = bool
  default     = true
}

variable "create_secgroup_default" {
  description = "Create the default security group"
  type        = bool
  default     = true
}
