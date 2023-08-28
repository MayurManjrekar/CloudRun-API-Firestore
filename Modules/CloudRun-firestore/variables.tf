variable "database_type" {
  type      = string
  default   = "FIRESTORE_NATIVE"
}

variable project_id {
  type      = string
  default   = null
  description = "Google Cloud project in which to create resources."
}

variable "location" {
  type      = string 
  default   = "nam5"
}