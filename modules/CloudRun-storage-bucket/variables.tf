variable "project_id" {
  description = "The ID to give the project. If not provided, the `name` will be used."
}

#Bucket
#Note !! change this to true once you create bucket

variable "storage_bucket_name" {
  description = "Custom storage bucket name."
  default     = ""
  type        = string
}

variable "storage_bucket_labels" {
  description = "Labels to apply to the storage bucket."
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "If supplied, the state bucket will be deleted even while containing objects."
  type        = bool
  default     = false
}

variable "region" {
  description = "Default region to create resources where applicable."
  type        = string
  default     = "us-central1"
}
