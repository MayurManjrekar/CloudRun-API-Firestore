variable "project_id" {
  description = "GCP project ID"
}

variable "region" {
  description = "name of specific region to deploy services into, e.g. eu-west1"
  default     = "europe-west1"
}

variable "api_gateway_name" {
  description = "gateway name"
  default     = "Bookshelf API Gateway"
}

variable "api_id" {
  description = "gateway ID"
  default     = "bookshelf-api-id"
}

variable "config_name" {
  description = "config name"
  default     = "Bookshelf API Config"
}

variable "gateway_id" {
  description = "gateway ID"
  default     = "bookshelf-gateway-id"
}

variable "gateway_name" {
  description = "gateway ID"
  default     = "Bookshelf Gateway"
}
