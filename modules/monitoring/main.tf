# Simple Uptime Check on LB host
resource "google_monitoring_uptime_check_config" "http" {
  display_name = "frontend-uptime"
  monitored_resource {
    type   = "uptime_url"
    labels = { host = var.primary_lb_host }
  }
  http_check { 
  path = "/" 
  port = 443 
  use_ssl = true 
  }
  timeout  = "10s"
  period   = "60s"
}

# Notification channel (email)
resource "google_monitoring_notification_channel" "email" {
  display_name = "DR-alert-email"
  type         = "email"
  labels = { email_address = var.alert_channel_email }
}

# Alert policy triggers Cloud Run Job via Webhook (invoke job execution URL)
# We use a docs-recommended HTTP notification (webhook) to Cloud Run invoker URL
resource "google_monitoring_alert_policy" "ap" {
  display_name = "Primary Down - Trigger DR"
  combiner     = "OR"
  conditions {
    display_name = "UptimeCheckFailed"
    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\""
      comparison      = "COMPARISON_LT"
      threshold_value = 1
      duration        = "120s"
      trigger { count = 1 }
      aggregations { 
      alignment_period = "60s" 
      per_series_aligner = "ALIGN_MEAN" 
      }
    }
  }
  notification_channels = [google_monitoring_notification_channel.email.name]
  documentation { content = "Primary down. DR job should run: ${var.run_job_name}" }
}
