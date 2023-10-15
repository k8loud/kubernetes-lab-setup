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
  default = "149.156.10.131"
}

variable "worker_hostname_suffix_length" {
  description = "Length of random suffix appended to Kube worker node's hostname"
  type = number
  default = 16
}
