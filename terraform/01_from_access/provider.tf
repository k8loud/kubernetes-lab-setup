terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.52.1"
    }
  }
}

provider "openstack" {
  user_name = var.openstack_username
  password = var.openstack_password
  auth_url = "https://api.cloud.cyfronet.pl:5000/v3"
  region = "RegionOne"
  user_domain_name = "Default"
  enable_logging = true
}
