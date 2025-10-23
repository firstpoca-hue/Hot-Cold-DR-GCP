# 

# GCP project where the GKE cluster will be created
variable "project_id" {
  description = "The ID of the project in which resources will be created."
  type        = string
}

# Region or zone for the GKE cluster
variable "region" {
  description = "The region where the GKE cluster will be deployed."
  type        = string
}

# Cluster name
variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
}

# Network (VPC) to which the cluster is attached
variable "network" {
  description = "The VPC network for the GKE cluster."
  type        = string
}

# Subnetwork (subnet) to which the cluster nodes are attached
variable "subnetwork" {
  description = "The subnetwork for the GKE cluster."
  type        = string
}
# Optional machine type override
variable "node_machine_type" {
  description = "Machine type for the GKE node pool."
  type        = string
  default     = "e2-standard-2"
}

# Optional node count override
variable "node_count" {
  description = "Number of nodes in the default node pool."
  type        = number
  default     = 2
}

variable "enable" {
  description = "Flag to enable or disable GKE cluster creation"
  type        = bool
  default     = true
}

