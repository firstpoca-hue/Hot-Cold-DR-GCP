resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id

  network    = var.network_self_link
  subnetwork = var.subnet_self_link

  # Create a temporary default node pool (needed by GKE),
  # then remove it after cluster creation.
  remove_default_node_pool = true
  initial_node_count       = 1

  # ✅ PATCH: make the temporary default node pool use pd-standard (or whatever you pass in)
  node_config {
    machine_type = var.node_machine_type
    disk_type    = var.disk_type        # e.g., "pd-standard"
    disk_size_gb = var.disk_size_gb     # e.g., 80

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    labels   = { env = "dev" }
    metadata = { disable-legacy-endpoints = "true" }

    shielded_instance_config {
      enable_secure_boot = true
    }
  }
  # ✅ END PATCH

  release_channel {
    channel = var.release_channel
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  enable_shielded_nodes = true

  # Network Policy only when NOT using Dataplane V2
  dynamic "network_policy" {
    for_each = var.enable_network_policy && !var.enable_dataplane_v2 ? [1] : []
    content {
      enabled  = true
      provider = "CALICO"
    }
  }

  # Dataplane V2 toggle
  datapath_provider = var.enable_dataplane_v2 ? "ADVANCED_DATAPATH" : null

  dynamic "private_cluster_config" {
    for_each = var.private_cluster ? [1] : []
    content {
      enable_private_nodes    = true
      enable_private_endpoint = false
      master_ipv4_cidr_block  = "172.16.0.0/28"
    }
  }
}

resource "google_container_node_pool" "primary" {
  name     = "primary-nodes"
  location = var.region
  project  = var.project_id
  cluster  = google_container_cluster.cluster.name

  node_config {
    machine_type = var.node_machine_type
    disk_type    = var.disk_type
    disk_size_gb = var.disk_size_gb

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    labels   = { env = "dev" }
    metadata = { disable-legacy-endpoints = "true" }

    shielded_instance_config {
      enable_secure_boot = true
    }
  }

  autoscaling {
    min_node_count = var.node_min_count
    max_node_count = var.node_max_count
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }

  depends_on = [google_container_cluster.cluster]
}
