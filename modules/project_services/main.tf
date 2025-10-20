terraform {
  required_providers { google = { source = "hashicorp/google" } }
}

resource "google_project_service" "services" {
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "run.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "secretmanager.googleapis.com",
    "iam.googleapis.com",
    "cloudbuild.googleapis.com",
    "pubsub.googleapis.com"
  ])
  project = var.project_id
  service = each.value
}
