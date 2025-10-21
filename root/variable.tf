# 

variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "primary_region" {
  description = "Primary region"
  type        = string
  default     = "us-central1"
}

variable "secondary_region" {
  description = "Secondary (cold) region"
  type        = string
  default     = "us-east1"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "dr-vpc"
}

variable "artifact_repo" {
  description = "Artifact Registry repo id"
  type        = string
  default     = "app-images"
}

variable "provision_secondary" {
  description = "Flag to provision the cold region GKE cluster"
  type        = bool
  default     = false
}

# cluster names used by root when calling gke modules
variable "cluster_name_primary" {
  description = "Primary GKE cluster name"
  type        = string
  default     = "gke-primary"
}

variable "cluster_name_secondary" {
  description = "Secondary GKE cluster name"
  type        = string
  default     = "gke-secondary"
}

# DB vars used by root
variable "db_version" {
  description = "Cloud SQL DB version"
  type        = string
  default     = "POSTGRES_15"
}

variable "db_tier" {
  description = "Cloud SQL machine tier"
  type        = string
  default     = "db-custom-1-3840"
}


variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}


