variable "project_id" {
  type = string
}

variable "pattern" {
  type = string
}

variable "region_a" {
  type = string
}

variable "region_b" {
  type = string
}

variable "artifact_registry_location" {
  type = string
}

variable "cluster_name_prefix" {
  type = string
}

variable "cluster_prefix" {
  type = string
}

variable "artifact_repo_location" {
  type = string
}

variable "artifact_registry_repo" {
  type = string
}

variable "credentials_file" {
  type = string
}

variable "subnets" {
  type = list(object({
    network_cidr = string
    region       = string
  }))
}

variable "network_name" {
  type = string
}

variable "gke_service_account_name" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "bastion_service_account_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_secondary_range_name" {
  type = string
}

variable "services_secondary_range_name" {
  type = string
}

variable "node_count" {
  type = number
}

variable "node_machine_type" {
  type = string
}

variable "node_disk_size" {
  type = number
}

variable "cluster_secondary_range" {
  type = string
}

variable "services_secondary_range" {
  type = string
}

variable "master_subnet_cidr" {
  type = string
}

variable "gke_account_email" {
  type = string
}
