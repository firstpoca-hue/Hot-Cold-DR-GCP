output "cluster_name" {
  value = google_container_cluster.gke_cluster.name
  description = "GKE cluster name"
}

output "endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
  description = "GKE endpoint (private/public depending on cluster config)"
}

output "location" {
  value = google_container_cluster.gke_cluster.location
}
