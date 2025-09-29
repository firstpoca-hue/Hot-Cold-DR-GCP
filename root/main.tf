module "project_services" {
  source     = "../modules/project_services"
  project_id = var.project_id
}

module "network" {
  source        = "../modules/network"
  project_id    = var.project_id
  region        = var.region
  network_name  = var.network_name
  subnet_name   = var.subnet_name
  subnet_cidr   = var.subnet_cidr
  pods_cidr     = var.pods_cidr
  services_cidr = var.services_cidr
  depends_on    = [module.project_services]
}

module "gke" {
  source                        = "../modules/gke"
  project_id                    = var.project_id
  region                        = var.region
  cluster_name                  = var.cluster_name
  release_channel               = var.release_channel
  network_self_link             = module.network.network_self_link
  subnet_self_link              = module.network.subnet_self_link
  node_machine_type             = var.node_machine_type
  disk_type                     =  var.disk_type
  disk_size_gb                  = var.disk_size_gb
  node_min_count                = var.node_min_count
  node_max_count                = var.node_max_count
  enable_network_policy         = var.enable_network_policy
  enable_dataplane_v2           = var.enable_dataplane_v2
  private_cluster               = var.private_cluster
  cluster_secondary_range_name  = module.network.pods_range_name
  services_secondary_range_name = module.network.services_range_name
  depends_on                    = [module.network]
}
