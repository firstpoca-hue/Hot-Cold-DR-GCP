resource "google_project_service" "services" {
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "dns.googleapis.com",
  ])
  project = var.project_id
  service = each.value
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "docker_repo" {
  project       = var.project_id
  location      = var.artifact_registry_location != "" ? var.artifact_registry_location : var.region_a
  repository_id = "gke-docker-repo"
  description   = "Multi-region Artifact Registry for container images"
  format        = "DOCKER"

  depends_on = [google_project_service.services]
}

resource "google_service_account" "gke_nodes" {
  project      = var.project_id
  account_id   = "gke-nodes"
  display_name = "GKE Nodes Service Account"
}
