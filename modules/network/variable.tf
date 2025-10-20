variable "project_id" {
  description = "The ID of the project in which to create the network."
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC network."
  type        = string
}

variable "regions" {
  description = "Map of regions to be used for subnets and NAT routers."
  type = object({
    primary   = string
    secondary = string
  })
}

variable "subnet_cidrs" {
  description = "Custom CIDR ranges for subnets per region (optional override)."
  type = object({
    primary   = optional(string, "10.10.0.0/20")
    secondary = optional(string, "10.20.0.0/20")
  })
  default = {
    primary   = "10.10.0.0/20"
    secondary = "10.20.0.0/20"
  }
}
