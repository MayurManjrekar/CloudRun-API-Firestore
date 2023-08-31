resource "google_project_service" "firestore" {
  project = var.project_id
  service = "firestore.googleapis.com"
}

resource "google_firestore_database" "database" {
  project     = var.project_id
  name        = "(default)"
  location_id = "nam5"
  type        = var.database_type
  #app_engine_integration_mode = "DISABLED"

  depends_on = [google_project_service.firestore ]
}
