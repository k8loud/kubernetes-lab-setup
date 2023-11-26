variable "openstack_username" {
  description = "OpenStack username"
  type        = string
}

variable "openstack_password" {
  description = "OpenStack password"
  type        = string
  sensitive   = true
}

variable "master_ip" {
  description = "IP address for master node"
  type = string
  default = "149.156.10.149"
}

variable "create_flavor_h2dslarge" {
  description = "Create h2d.slarge flavor (for kube-master VM)"
  type        = bool
  default     = true
}

variable "create_flavor_h2medium" {
  description = "Create h2d.slarge flavor (for kube-worker VM)"
  type        = bool
  default     = true
}
