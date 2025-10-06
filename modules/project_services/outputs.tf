output "artifact_registry_repo" {
  value = google_artifact_registry_repository.docker_repo.id
}



output "gke_service_account_email" {
  value = google_service_account.gke_nodes.email
}
