output "cluster_name" { 
value = google_container_cluster.cluster.name
}

output "cluster_region" { 
value = google_container_cluster.cluster.location 
}

output "endpoint" { 
value = google_container_cluster.cluster.endpoint
}

output "workload_pool" { 
value = google_container_cluster.cluster.workload_identity_config[0].workload_pool
}