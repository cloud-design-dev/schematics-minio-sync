resource "ibm_is_instance" "minio_instance" {
  depends_on = [ibm_is_security_group.minio_sync]
  name       = "minio-sync"
  image      = data.ibm_is_image.os_image.id
  profile    = var.vpc_instance_profile

  primary_network_interface {
    subnet          = var.vpc_subnet_id
    security_groups = [ibm_is_security_group.minio_sync.id]
  }

  resource_group = data.ibm_resource_group.project_rg.id
  tags           = [var.vpc_name]

  vpc  = data.ibm_is_vpc.project_vpc.id
  zone = data.ibm_is_zones.regional_zones.zones[0]
  keys = [data.ibm_is_ssh_key.linux_key.id]
  user_data = templatefile("${path.module}/installer.sh", {
    source_account_bucket          = var.source_account_bucket,
    source_account_endpoint        = var.source_account_endpoint,
    source_account_access_key      = var.source_account_access_key,
    source_account_secret_key      = var.source_account_secret_key,
    destination_account_bucket     = var.destination_account_bucket,
    destination_account_endpoint   = var.destination_account_endpoint,
    destination_account_access_key = var.destination_account_access_key,
    destination_account_secret_key = var.destination_account_secret_key
  })
}

resource "ibm_is_security_group" "minio_sync" {
  resource_group = data.ibm_resource_group.project_rg.id
  vpc            = data.ibm_is_vpc.project_vpc.id
}

resource "ibm_is_security_group_rule" "outbound_minio" {
  depends_on = [ibm_is_security_group.minio_sync]
  group      = ibm_is_security_group.minio_sync.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
}

resource "ibm_is_security_group_rule" "inbound_from_cse" {
  depends_on = [ibm_is_security_group.minio_sync]
  group      = ibm_is_security_group.minio_sync.id
  direction  = "inbound"
  remote     = data.ibm_is_vpc.project_vpc.cse_source_addresses[0].address
}

