
data "google_storage_bucket" "bucket" {
  count = var.bucket_exist ? 1 : 0  
  name  = var.state_bucket_name
}

locals {
  bucket_name = try(element(data.google_storage_bucket.bucket.*.name, 0), null)
}


resource "google_storage_bucket" "statefile-bucket" {
  count = var.bucket_exist ? ( local.bucket_name == var.state_bucket_name ? 0 : 1) : 1
  project                     = var.project_id           
  name                        = var.state_bucket_name
  location                    = var.region
  labels                      = var.storage_bucket_labels
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}
