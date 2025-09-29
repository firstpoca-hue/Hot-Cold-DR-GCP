resource "google_project_service" "apis" {
for_each = toset([
"container.googleapis.com",
"compute.googleapis.com",
"iam.googleapis.com",
"serviceusage.googleapis.com",
"servicenetworking.googleapis.com",
"monitoring.googleapis.com",
"logging.googleapis.com",
# optional:
# "dns.googleapis.com",
# "artifactregistry.googleapis.com",
])
project = var.project_id
service = each.key
disable_dependent_services = false
}