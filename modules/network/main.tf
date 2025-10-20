resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

# subnets per region
resource "google_compute_subnetwork" "subnets" {
  for_each                 = {
    primary   = { 
    region = var.regions.primary 
    cidr = "10.10.0.0/20" 
    }
    secondary = { 
    region = var.regions.secondary
    cidr = "10.20.0.0/20" 
    }
  }
  name          = "${var.vpc_name}-${each.key}"
  ip_cidr_range = each.value.cidr
  region        = each.value.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}

# Cloud NAT for both regions
resource "google_compute_router" "router" {
  for_each = {
    primary   = var.regions.primary
    secondary = var.regions.secondary
  }
  name    = "${var.vpc_name}-router-${each.key}"
  region  = each.value
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
  for_each                           = google_compute_router.router
  name                               = "${var.vpc_name}-nat-${each.key}"
  router                             = each.value.name
  region                             = each.value.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# Private Service Access (for Cloud SQL private IP)
resource "google_compute_global_address" "psa" {
  name          = "${var.vpc_name}-psa"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "psa" {
  network                 = google_compute_network.vpc.id
  service                 = "services/servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.psa.name]
}

