# 

output "artifact_registry_repo_id" {
  value = google_artifact_registry_repository.repo.id
}

output "gke_primary_cluster_name" {
  value = try(module.gke_hot.cluster_name, null)
}

output "gke_primary_endpoint" {
  value = try(module.gke_hot.endpoint, null)
}

output "gke_secondary_cluster_name" {
  value = try(module.gke_cold.cluster_name, null)
}

output "gke_secondary_endpoint" {
  value = try(module.gke_cold.endpoint, null)
}

output "db_primary_connection_name" {
  value = google_sql_database_instance.db_primary.connection_name
}
