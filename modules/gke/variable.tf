variable "project_id" { 
type = string 
}

variable "region" { 
type = string 
}

variable "cluster_name"{ 
type = string 
}

variable "release_channel" { 
type = string 
}


variable "network_self_link" { 
type = string 
}

variable "subnet_self_link" {
type = string 
}


variable "cluster_secondary_range_name" { 
type = string
}

variable "services_secondary_range_name" { 
type = string
}

variable "node_machine_type" {
 type = string 
}

variable "node_min_count" {
type = number 
}

variable "node_max_count" { 
type = number 
}


variable "enable_network_policy" { 
type = bool 
}

variable "enable_dataplane_v2" { 
type = bool 
}

variable "private_cluster" {
 type = bool 
}