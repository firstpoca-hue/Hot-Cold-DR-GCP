project_id = "hot-cold-drp"
region = "asia-south1" # Mumbai
network_name = "gke-vpc"
subnet_name = "gke-subnet"
subnet_cidr = "10.10.0.0/16"
pods_cidr = "10.20.0.0/14"
services_cidr = "10.24.0.0/20"
cluster_name = "demo-gke"
release_channel = "REGULAR"
node_machine_type = "e2-standard-4"
node_min_count = 1
node_max_count = 2
disk_type = "pd-standard"
disk_size_gb = 80


# Optional features
enable_network_policy = false
enable_dataplane_v2 = false
private_cluster = false