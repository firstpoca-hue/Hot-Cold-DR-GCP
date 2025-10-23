locals {
  cluster_name = var.cluster_name
}

##############################################
# Primary / Secondary GKE Cluster (Conditional)
##############################################

resource "google_container_cluster" "gke_cluster" {
  count               = var.enable ? 1 : 0
  name                = local.cluster_name
  location            = var.region
  project             = var.project_id
  network             = var.network
  subnetwork          = var.subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {}

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  lifecycle {
    ignore_changes = [
      node_config,
      node_pool,
    ]
  }
}

##############################################
# Node Pool (Created only when cluster exists)
##############################################
resource "google_container_node_pool" "default_pool" {
  count      = var.enable ? 1 : 0
  project    = var.project_id
  cluster    = google_container_cluster.gke_cluster[0].name
  location   = var.region
  name       = "default-node-pool"
  node_count = 2

  node_config {
    machine_type  = "e2-standard-2"
    disk_size_gb  = 50
    oauth_scopes  = ["https://www.googleapis.com/auth/cloud-platform"]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = {
      environment = var.enable ? "active" : "dr"
      role        = var.enable ? "primary" : "secondary"
    }
  }
}
