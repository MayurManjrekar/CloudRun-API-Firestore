resource "google_storage_bucket" "storage-bucket" {
  project                     = var.project_id           
  name                        = var.storage_bucket_name
  location                    = var.region
  labels                      = var.storage_bucket_labels
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}
