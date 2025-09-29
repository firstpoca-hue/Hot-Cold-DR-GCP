output "enabled_services" {
value = [for k in google_project_service.apis : k.service]
}