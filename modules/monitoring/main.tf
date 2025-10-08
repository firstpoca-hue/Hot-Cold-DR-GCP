# Create Monitoring Workspace
# resource "google_monitoring_workspace" "workspace" {
#   project = var.project_id
# }

# Create an alerting policy for CPU usage
resource "google_monitoring_alert_policy" "cpu_alert" {
  display_name = var.alert_policy_name
  combiner     = "OR"
  conditions {
    display_name = "High CPU usage"
    condition_threshold {
      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\""
      comparison = "COMPARISON_GT"
      threshold_value = var.metric_threshold
      duration = "60s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [] # You can attach notification channels here
  enabled = true
}

resource "google_project_service" "monitoring" {
  project = var.project_id
  service = "monitoring.googleapis.com"
  disable_on_destroy = false
}
