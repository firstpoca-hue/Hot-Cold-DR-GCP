
output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}

output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "subnet_primary_self_link" {
  value = google_compute_subnetwork.subnets["primary"].self_link
}

output "subnet_secondary_self_link" {
  value = google_compute_subnetwork.subnets["secondary"].self_link
}

output "subnet_primary_name" {
  value = google_compute_subnetwork.subnets["primary"].name
}

output "subnet_secondary_name" {
  value = google_compute_subnetwork.subnets["secondary"].name
}
