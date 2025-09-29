output "cluster_name" {
  value = module.gke.cluster_name
}

output "cluster_region" {
  value = module.gke.cluster_region
}

output "endpoint" {
  value = module.gke.endpoint
}

output "workload_pool" {
  value = module.gke.workload_pool
}


output "gcloud_get_creds_cmd" {
  value = "gcloud container clusters get-credentials ${module.gke.cluster_name} --region ${module.gke.cluster_region} --project ${var.project_id}"
}