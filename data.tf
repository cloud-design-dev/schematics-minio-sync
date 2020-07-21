data "ibm_is_image" "os_image" {
  name = var.vpc_os_image
}

data "ibm_is_vpc" "project_vpc" {
  name = var.vpc_name
}

data "ibm_resource_group" "project_rg" {
  name = var.vpc_resource_group
}

data "ibm_is_ssh_key" "linux_key" {
  name = var.vpc_ssh_key
}

data "ibm_is_zones" "regional_zones" {
  region = var.vpc_region
}
