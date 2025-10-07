
variable "project_id" {
 type = string
default = "hot-cold-drp"
}
variable "artifact_repo_location" { 
default = "us" 
}
variable "pattern" { 
default = "dev" 
}

variable "subnet_cidrs" {
 type = list(string)
  default = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "artifact_registry_repo" {
  type = string
  default = "gcr.io/hot-cold-drp/app-images"
  
}


variable "artifact_registry_location" {
  description = "Region or multi-region for Artifact Registry"
  type        = string
  default     = "us" # multi-region US
}
variable "region_a" {
  description = "Hot region (optional) for Artifact Registry or other services"
  type        = string
  default     = "us"
}

variable "kms_key_ring_name" {
   type = string 
}

variable "kms_crypto_key_name" {
   type = string
}

variable "region" {
  
}