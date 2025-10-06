# 

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
}

# Artifact Registry (multi-region)
resource "google_artifact_registry_repository" "docker_repo" {
  project      = var.project_id
  location     = "us" # multi-region US
  repository_id = "gke-docker-repo"
  description  = "Multi-region Artifact Registry for container images"
  format       = "DOCKER"

  depends_on = [google_project_service.services]
}

# GKE Node Service Account
resource "google_service_account" "gke_nodes" {
  project      = var.project_id
  account_id   = "gke-nodes"
  display_name = "GKE Nodes Service Account"
}

resource "google_container_cluster" "this" {
  name               = var.cluster_name
  location           = var.region
  project            = var.project_id
  initial_node_count = 1  # must be >= 1
  deletion_protection = true

  node_config {
    machine_type  = var.node_machine_type
    disk_size_gb  = var.disk_size_gb
    oauth_scopes  = ["https://www.googleapis.com/auth/cloud-platform"]
    service_account = google_service_account.gke_nodes.email
  }

  remove_default_node_pool = true
}

resource "google_project_service" "logging" {
  service                     = "logging.googleapis.com"
  disable_on_destroy           = true
  disable_dependent_services   = true
  project                     = var.project_id
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-nodes"
  location   = var.region
  cluster    = google_container_cluster.this.name
  node_count = 2

  node_config {
    machine_type = "e2-medium"   # you can change to e2-standard-2 or larger
    disk_size_gb = 50
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
