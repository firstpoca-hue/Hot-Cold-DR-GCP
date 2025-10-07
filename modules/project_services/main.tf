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
  kms_key_name  = google_kms_crypto_key.ar.id

  depends_on = [google_project_service.services]
}

resource "google_service_account" "gke_nodes" {
  project      = var.project_id
  account_id   = "gke-nodes"
  display_name = "GKE Nodes Service Account"
}

resource "google_kms_key_ring" "ar" {
  name     = var.kms_key_ring_name
  location = var.region
}

resource "google_kms_crypto_key" "ar" {
  name            = var.kms_crypto_key_name
  key_ring        = google_kms_key_ring.ar.id
  rotation_period = "7776000s" # 90 days
  purpose         = "ENCRYPT_DECRYPT"
}
