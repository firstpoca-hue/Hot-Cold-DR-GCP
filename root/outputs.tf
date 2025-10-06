output "network_name" {
  value = module.network.network_name
}

output "hot_cluster_name" {
  value = module.gke_hot.cluster_name
}

output "hot_cluster_endpoint" {
  value = module.gke_hot.endpoint
}

output "artifact_repository" {
  value = module.project_services.artifact_registry_repo
}
output "artifact_registry_repo" {
  value = module.project_services.artifact_registry_repo
}