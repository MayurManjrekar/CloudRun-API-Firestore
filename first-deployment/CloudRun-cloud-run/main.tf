resource "google_project_service" "cloud-run-admin" {
  project = var.project_id
  service = "run.googleapis.com"
}

resource "google_cloud_run_service" "cloud-run" {
  provider                   = google-beta
  name                       = var.service_name
  location                   = var.location
  project                    = var.project_id
  depends_on                 = [google_project_service.cloud-run-admin]

  template {
    spec {
      #service_account_name = var.service_acc
      containers {
        image   = var.image

        startup_probe {
          initial_delay_seconds = 0
          timeout_seconds       = 1
          period_seconds        = 10
          failure_threshold     = 2 
          tcp_socket {
            port = 8080
          }
        }

        liveness_probe {    
          initial_delay_seconds = 0
          timeout_seconds       = 1
          period_seconds        = 10
          failure_threshold     = 2
          http_get {
            path = "/"
            port = 8080
          }
        }

        ports {
          name           = var.ports["name"] 
          container_port = var.ports["port"] 
        }

        resources {
          limits = {
            cpu    = "${var.cpus * 1000}m"
            memory = "${var.memory}Mi"
          }
        }
      }
    }

    metadata {
      labels = var.labels
      annotations = merge(
        {
          "run.googleapis.com/cpu-throttling"        = var.cpu_throttling
          "autoscaling.knative.dev/maxScale"         = var.max_instances
          "autoscaling.knative.dev/minScale"         = var.min_instances
          "run.googleapis.com/execution-environment" = var.execution_environment
          "run.googleapis.com/startup-cpu-boost"     = var.startup_boost
        }
      )
    }
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
    ]
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource google_cloud_run_service_iam_member public_access {
  service   = google_cloud_run_service.cloud-run.name
  location  = google_cloud_run_service.cloud-run.location
  project   = google_cloud_run_service.cloud-run.project
  role      = "roles/run.invoker"
  member    = "allUsers"
}
