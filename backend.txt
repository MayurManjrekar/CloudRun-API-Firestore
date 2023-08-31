terraform {
   backend "gcs" {
   bucket = "statefiles-bucket-mkjnj"
   prefix = "terraform/state"
  }
}
