variable "project_id" {
  type = string
}

variable "region" {
  description = "region in which the resources would be deployed" 
  type        = string
  default     = "us-central1"
}

variable "neg_name" {
  description = "name of serverless network endpoint group"
  type        = string
}

variable "lb_name" {
  description = "name of the external load balancer created" 
  type        = string
}

variable "api_gateway_name" {
  description = "name of api gateway" 
  type        = string
}

variable "api_id" {
  description = "api id , all small alphabets" 
  type        = string
}

variable "config_name" {
  description = "name of the configuration" 
  type        = string
}

variable "gateway_id" {
  description = "gateway api ID , all small alphabets" 
  type        = string
}

variable "gateway_name" {
  description = "name of the API gateway" 
  type        = string
}