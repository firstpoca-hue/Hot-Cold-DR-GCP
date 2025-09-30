output "enabled_services" {
  description = "APIs enabled by this module"
  value       = sort([for s in google_project_service.apis : s.service])
}
