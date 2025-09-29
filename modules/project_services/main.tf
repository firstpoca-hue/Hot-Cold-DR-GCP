# modules/project_services/main.tf

locals {
  # enable these first
  core_apis = [
    "iam.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
  ]

  # enable other APIs (no duplicates from core_apis)
  other_apis = [
    "servicenetworking.googleapis.com",
    "dns.googleapis.com",
    "artifactregistry.googleapis.com",
  ]
}

# Enable core APIs
resource "google_project_service" "core" {
  for_each = toset(local.core_apis)
  project  = var.project_id
  service  = each.key

  disable_dependent_services = false
  disable_on_destroy         = false

  timeouts { 
  create = "20m" 
  update = "20m" 
}
}

# Enable the rest
resource "google_project_service" "others" {
  for_each = toset(local.other_apis)
  project  = var.project_id
  service  = each.key

  disable_dependent_services = false
  disable_on_destroy         = false
  depends_on                 = [google_project_service.core]

  timeouts { 
  create = "20m" 
  update = "20m" 
}
}

# Keep Logging & Monitoring on, never destroy
resource "google_project_service" "logging" {
  project            = var.project_id
  service            = "logging.googleapis.com"
  disable_on_destroy = false
  lifecycle { 
  prevent_destroy = true 
  }
}

resource "google_project_service" "monitoring" {
  project            = var.project_id
  service            = "monitoring.googleapis.com"
  disable_on_destroy = false
  lifecycle { 
  prevent_destroy = true 
  }
}
