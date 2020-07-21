variable "vpc_name" {
  description = "The VPC where minio sync instance will be created."
  default     = ""
  type        = string
}

variable "os_image" {
  description = "Default OS image for minio client. Currently tested with Ubuntu 16 and 18."
  type        = string
  default     = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}

variable "linux_ssh_key" {
  description = "SSH key to add to instance."
  type        = string
  default     = ""
}

variable "region" {
  description = "VPC Region where resources will be deployed."
  type        = string
  default     = ""
}

variable "resource_group" {
  description = "Resource group where resources will be created."
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet where VPC instance will be deployed."
  type        = string
  default     = ""
}

variable "source_account_bucket" {
  description = "Bucket name on the source account. You are copying from this account."
  type        = string
  default     = ""
}


variable "destination_account_bucket" {
  description = "Bucket name on the destination account. You are copying to this account."
  type        = string
  default     = ""
}


variable "source_account_endpoint" {
  description = "COS Endpoint for source account bucket. You are copying from this account."
  type        = string
  default     = ""
}


variable "destination_account_endpoint" {
  description = "COS Endpoint for destination account bucket. You are copying to this account."
  type        = string
  default     = ""
}

variable "source_account_access_key" {
  description = "COS Access Key for source account bucket. You are copying from this account."
  type        = string
  default     = ""
}

variable "source_account_secret_key" {
  description = "COS Secret Key for source account bucket. You are copying from this account."
  type        = string
  default     = ""
}

variable "destination_account_access_key" {
  description = "COS Access Key for destination account bucket. You are copying to this account."
  type        = string
  default     = ""
}

variable "destination_account_secret_key" {
  description = "COS Secret Key for destination account bucket. You are copying to this account."
  type        = string
  default     = ""
}


variable "default_instance_profile" {
  description = "Default instance profile size."
  type        = string
  default     = "cx2-2x4"
}
