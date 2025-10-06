project_id = "hot-cold-drp"
pattern    = "dev"

region_a = "us-central1"      # Primary (Hot)
region_b = "us-west1"         # Secondary (Cold)
artifact_registry_location = "us"
cluster_name_prefix = "app-cluster"
cluster_prefix      = "dev-gke"

artifact_repo_location = "us"
artifact_registry_repo = "gcr.io/hot-cold-drp/app-images"

credentials_file = "/home/user/gcp-keys/my-project-sa.json"

subnets = [
  {
    network_cidr = "10.0.0.0/16"
    region       = "us-central1"  # hot subnet
  },
  {
    network_cidr = "10.1.0.0/16"
    region       = "us-west1"     # cold subnet
  }
]


network_name                 = "tf-gke-vpc"
gke_service_account_name     = "tf-gke-sa"
private_subnet_cidr          = "10.10.0.0/24"
public_subnet_cidr           = "10.20.0.0/24"
bastion_service_account_name = "tf-bastion-sa"

cluster_name                  = "gke-cluster"
cluster_secondary_range_name  = "gke-pods"
services_secondary_range_name = "gke-services"

node_count        = "1" # Regional, x 3 zones
node_machine_type = "e2-standard-4"
node_disk_size    = "30" # In GB

cluster_secondary_range = "10.11.0.0/16"

# Used for Services (ClusterIP services get IPs from here). Much smaller than Pods range, but must handle number of services you’ll deploy.
services_secondary_range = "10.12.0.0/20"

# User for control plane (master API server). This block must not overlap with any subnet ranges you already use (pods, services, subnets).
master_subnet_cidr = "172.16.0.0/28"

gke_account_email = "terraform-ci@hot-cold-drp.iam.gserviceaccount.com"

