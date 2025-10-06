variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "GCP region where the cluster will be created"
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "network" {
  description = "VPC network name (self link or name)"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork name"
  type        = string
}

variable "initial_node_count" {
  description = "Initial node count for node pool"
  type        = number
  default     = 1
}

variable "min_nodes" {
  description = "Minimum nodes for autoscaling"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum nodes for autoscaling"
  type        = number
  default     = 3
}

variable "node_machine_type" {
  description = "Machine type for nodes"
  type        = string
  default     = "e2-standard-4"
}

variable "enable_private_cluster" {
  description = "Whether to create private nodes"
  type        = bool
  default     = true
}

variable "service_account_email" {
  description = "Optional GCE service account for node VMs (prefer a least-priv SA)"
  type        = string
  default     = null
}

variable "workload_identity_pool" {
  description = "Optional workload identity pool in the form PROJECT.svc.id.goog (e.g. my-project.svc.id.goog)"
  type        = string
  default     = null
}

variable "enable_autoprovisioning" {
  description = "Enable Node Autoprovisioning for cluster"
  type        = bool
  default     = false
}

variable "disk_size_gb" {
  type    = number
  default = 50
}
