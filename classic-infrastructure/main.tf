resource "ibm_compute_vm_instance" "node" {
  hostname             = var.hostname
  domain               = var.domain
  os_reference_code    = var.os_image
  datacenter           = var.datacenter
  network_speed        = 1000
  hourly_billing       = true
  private_network_only = false
  local_disk           = true
  user_metadata = templatefile("${path.module}/installer.sh", {
    source_account_bucket          = var.source_account_bucket,
    source_account_endpoint        = var.source_account_endpoint,
    source_account_access_key      = var.source_account_access_key,
    source_account_secret_key      = var.source_account_secret_key,
    destination_account_bucket     = var.destination_account_bucket,
    destination_account_endpoint   = var.destination_account_endpoint,
    destination_account_access_key = var.destination_account_access_key,
    destination_account_secret_key = var.destination_account_secret_key
  })
  flavor_key_name            = var.flavor
  tags                       = [var.datacenter, var.project_name]
  ssh_key_ids                = [data.ibm_compute_ssh_key.deploymentKey.id]
  public_security_group_ids  = [ibm_security_group.public_gateway.id]
  private_security_group_ids = [ibm_security_group.private.id]
}

## Security group public 
resource "ibm_security_group" "public_gateway" {
  name        = "${var.project_name}-sg-public"
  description = "Allow outbound to grab minio client and system updates."
}

## Security group rule 
resource "ibm_security_group_rule" "allow_outbound_public" {
  direction         = "egress"
  ether_type        = "IPv4"
  protocol          = "tcp"
  security_group_id = ibm_security_group.public_gateway.id
}

## Security group public 
resource "ibm_security_group" "private_system" {
  name        = "${var.project_name}-sg-private"
  description = "Allow ingress / egress for backend traffic. This will be ICOS traffic."
}

## Security group rule 
resource "ibm_security_group_rule" "allow_outbound_private" {
  direction         = "egress"
  ether_type        = "IPv4"
  protocol          = "tcp"
  security_group_id = ibm_security_group.private_system.id
}

## Security group rule for inbound minio traffic (Needs to be tweaked to match ports)
resource "ibm_security_group_rule" "allow_inbound_private" {
  direction         = "ingress"
  ether_type        = "IPv4"
  protocol          = "tcp"
  security_group_id = ibm_security_group.private_system.id
}

## Security group rule for inbound ssh traffic
resource "ibm_security_group_rule" "allow_inbound_ssh" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  security_group_id = ibm_security_group.private_system.id
}