# 

# Enable required APIs & Artifact Registry
module "project_services" {
  source                     = "../modules/project_services"
  project_id                 = var.project_id
  artifact_registry_location = var.region_a

}

# Network (only hot region for now)
module "network" {
  source     = "../modules/network"
  project_id = var.project_id
  region_a   = var.region_a
}

# Hot GKE cluster
module "gke_hot" {
  source                 = "../modules/gke"
  project_id             = var.project_id
  region                 = var.region_a
  cluster_name           = "${var.cluster_name_prefix}-hot"
  network                = module.network.network_name
  subnetwork             = module.network.subnet_name
  initial_node_count     = 1
  min_nodes              = 1
  max_nodes              = 3
  service_account_email  = module.project_services.gke_service_account_email
  workload_identity_pool = "${var.project_id}.svc.id.goog"
}

module "monitoring" {
  source               = "../modules/monitoring"
  project_id           = var.project_id
  workspace_display_name = "my-monitoring-workspace"
  alert_policy_name    = "cpu-alert"
  metric_threshold     = 75
}
