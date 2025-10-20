# ==========================================================
# 0) Enable Required APIs
# ==========================================================
module "services" {
  source     = "../modules/project_services"
  project_id = var.project_id
}

# ==========================================================
# 1) Network
# ==========================================================
module "network" {
  source     = "../modules/network"
  project_id = var.project_id
  vpc_name   = var.vpc_name
  regions = {
    primary   = var.primary_region
    secondary = var.secondary_region
  }

  depends_on = [module.services]
}

# ==========================================================
# 2) Artifact Registry (for container images)
# ==========================================================
resource "google_artifact_registry_repository" "repo" {
  location      = var.primary_region
  repository_id = var.artifact_repo
  description   = "App images"
  format        = "DOCKER"
}

# ==========================================================
# 3) Primary (HOT) GKE Cluster
# ==========================================================
module "gke_hot" {
  source     = "../modules/gke"
  project_id = var.project_id
  region     = var.primary_region

  cluster_name = var.cluster_name_primary
  network      = module.network.vpc_self_link
  subnetwork   = module.network.subnet_primary_self_link
  enable       = true
}

# ==========================================================
# 4) Secondary (COLD) GKE Cluster (optional)
# ==========================================================
module "gke_cold" {
  source     = "../modules/gke"
  project_id = var.project_id
  region     = var.secondary_region

  cluster_name = var.cluster_name_secondary
  network      = module.network.vpc_self_link
  subnetwork   = module.network.subnet_secondary_self_link
  enable       = var.provision_secondary
}

# ==========================================================
# 5) Cloud SQL (Primary + Cross-region replica)
# ==========================================================
resource "random_password" "db" {
  length  = 24
  special = true
}

resource "google_sql_database_instance" "db_primary" {
  name             = "app-pg-primary"
  database_version = var.db_version
  region           = var.primary_region
  project          = var.project_id

  settings {
    tier              = var.db_tier
    availability_type = "REGIONAL"

    ip_configuration {
      ipv4_enabled    = false
      private_network = module.network.vpc_self_link
    }

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
    }
  }

  depends_on = [module.network]
}

resource "google_sql_user" "appuser" {
  name     = "appuser"
  instance = google_sql_database_instance.db_primary.name
  password = random_password.db.result
}

resource "google_sql_database" "appdb" {
  name     = "appdb"
  instance = google_sql_database_instance.db_primary.name
}

resource "google_sql_database_instance" "db_replica" {
  name                 = "app-pg-replica"
  database_version     = var.db_version
  master_instance_name = google_sql_database_instance.db_primary.name
  region               = var.secondary_region
  project              = var.project_id

  settings {
    tier = var.db_tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = module.network.vpc_self_link
    }
  }
}

# ==========================================================
# 6) Secrets in Secret Manager
# ==========================================================
resource "google_secret_manager_secret" "db_pass" {
  secret_id = "db-password"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "api_key_v" {
  secret      = google_secret_manager_secret.db_pass.id
  secret_data = "super-secure-db-password" # or use variable(var.db_password)
}


# Store DB password
# resource "google_secret_manager_secret" "db_pass" {
#   name    = "db-password"
#   project = var.project_id

#   replication {
#     automatic = true
#   }
# }


