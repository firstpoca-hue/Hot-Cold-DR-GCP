# modules/project_services/main.tf

locals {
  core_apis = [
    "iam.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "cloudresourcemanager.googleapis.com"  
  ]

  other_apis = [
    "servicenetworking.googleapis.com",
    "dns.googleapis.com",
    "artifactregistry.googleapis.com",
  ]
}


resource "google_project_service" "services" {
  for_each = toset([
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
  ])
  project            = var.project_id
  service            = each.key
  disable_dependent_services = true
  disable_on_destroy = false

  lifecycle {
    prevent_destroy = true
  }
}
