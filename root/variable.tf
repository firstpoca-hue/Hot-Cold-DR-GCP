# 

variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region_a" {
  type        = string
  description = "Hot (primary) region"
}

variable "region_b" {
  type        = string
  description = "Cold (secondary) region"
}

variable "cluster_name_prefix" {
  type    = string
  default = "drp-cluster"
}

variable "artifact_registry_location" {

}