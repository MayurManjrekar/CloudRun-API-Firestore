variable "project_id" {
  type = string
}

variable "service_acc" {
  type = string
}

variable "region" {
  description = "region in which the resources would be deployed" 
  type        = string
  default     = "us-central1"
}

variable "cloudrun_instance_name" {
  description = "name of cloud run instance"
  type        = string
}

variable "vpc_name" {
  type    = string
}

variable "subnet_name" {
  type    = string
}

variable "subnet_ip_ranges" {
  type    = string
}

