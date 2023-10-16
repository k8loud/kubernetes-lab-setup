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

variable "access_ip" {
  description = "IP address for access node"
  type = string
  default = "149.156.10.130"
}


