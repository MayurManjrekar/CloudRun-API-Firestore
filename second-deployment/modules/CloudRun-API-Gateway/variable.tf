variable "project_id" {
  description = "GCP project ID"
}

variable "region" {
  description = "name of specific region to deploy services into, e.g. eu-west1"
  default     = "us-central1"
  type        = string 
}

variable "api_gateway_name" {
  description = "gateway name"
  type = string 
  default     = "Bookshelf API Gateway"
}

variable "api_id" {
  description = "gateway ID"
  type        = string 
  default     = "bookshelf-api-id"
}

variable "config_name" {
  description = "config name"
  type        = string 
  default     = "Bookshelf API Config"
}

variable "gateway_id" {
  description = "gateway ID"
  type        = string 
  default     = "bookshelf-gateway-id"
}

variable "gateway_name" {
  description = "gateway ID"
  type        = string 
  default     = "Bookshelf Gateway"
}


variable "config_file_path" {
  description = "config file path"
  type        = string 
}

contents 
variable "contents " {
  type        = string 
}
