variable "iaas_classic_username" {
  description = "IBM Cloud IaaS Username."
  type        = string
  default     = ""
}

variable "iaas_classic_api_key" {
  description = "IBM Cloud IaaS User API key."
  type        = string
  default     = ""
}

variable "os_image" {
  description = "Default operating system image for compute instance."
  type        = string
  default     = "UBUNTU_18_64"
}

variable "flavor" {
  description = "Default instance size."
  type        = string
  default     = "BL2_2X4X100"
}

variable "domain" {
  description = "Domain for compute instance."
  type        = string
  default     = ""
}

variable "datacenter" {
  description = "Datacenter where instance will be deployed."
  type        = string
  default     = ""
}

variable "ssh_key" {
  description = "Classic IaaS ssh key to add to compute instance."
  type        = string
  default     = ""
}

variable "hostname" {
  description = "Hostname for instance."
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