# 

variable "project_id" {
  type        = string
  description = "The project ID to deploy the network"
}

variable "network_name" {
  type        = string
  default     = "gke-vpc"
}

variable "region_a" {
  type        = string
  description = "Primary region"
}

variable "subnet_cidr_a" {
  type        = string
  default     = "10.10.0.0/20"
}
