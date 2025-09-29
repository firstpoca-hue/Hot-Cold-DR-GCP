variable "project_id" {
  type = string
}
variable "region" {
  type    = string
  default = "asia-south1"
}

variable "network_name" {
  type    = string
  default = "gke-vpc"
}

variable "subnet_name" {
  type    = string
  default = "gke-subnet"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "pods_cidr" {
  type    = string
  default = "10.20.0.0/14"
}

variable "services_cidr" {
  type    = string
  default = "10.24.0.0/20"
}


variable "cluster_name" {
  type    = string
  default = "demo-gke"
}

variable "release_channel" {
  type    = string
  default = "REGULAR"
} # RAPID|REGULAR|STABLE


variable "node_machine_type" {
  type    = string
  default = "e2-standard-4"
}

variable "node_min_count" {
  type    = number
  default = 1
}

variable "node_max_count" {
  type    = number
  default = 3
}


# Optional toggles
variable "enable_network_policy" {
  type    = bool
  default = false
}

variable "enable_dataplane_v2" {
  type    = bool
  default = false
}

variable "private_cluster" {
  type    = bool
  default = false
}

variable "disk_type" {
  type    = string
  default = "pd-standard" # or "pd-ssd"
}

variable "disk_size_gb" {
  type    = number
  default = 50
}
