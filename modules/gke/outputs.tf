output "artifact_registry_repo" {
  value = google_artifact_registry_repository.docker_repo.id
}

output "gke_service_account_email" {
  value = google_service_account.gke_nodes.email
}

output "cluster_name" {
  value = google_container_cluster.primary_gke.name
}
output "endpoint" {
  value = google_container_cluster.primary_gke.endpoint
}