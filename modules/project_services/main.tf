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
    "artifactregistry.googleapis.com"
  ]
}

resource "google_project_service" "apis" {
  for_each = toset([
    "iam.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com",
    # DO NOT include logging, monitoring, or serviceusage
  ])

  project                     = var.project_id
  service                     = each.key
  disable_dependent_services = true
  disable_on_destroy          = false

  lifecycle {
    prevent_destroy = true
  }
}
