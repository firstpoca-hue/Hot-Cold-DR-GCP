##############################################
# GKE Cluster Outputs (Safe for Conditional Count)
##############################################

output "cluster_name" {
  description = "Name of the GKE cluster"
  value       = var.enable ? google_container_cluster.gke_cluster[0].name : null
}

output "cluster_location" {
  description = "Region or zone where the GKE cluster is deployed"
  value       = var.enable ? google_container_cluster.gke_cluster[0].location : null
}

output "cluster_endpoint" {
  description = "GKE API endpoint (private/public depending on cluster config)"
  value       = var.enable ? google_container_cluster.gke_cluster[0].endpoint : null
}

output "cluster_self_link" {
  description = "Self link of the GKE cluster"
  value       = var.enable ? google_container_cluster.gke_cluster[0].self_link : null
}
