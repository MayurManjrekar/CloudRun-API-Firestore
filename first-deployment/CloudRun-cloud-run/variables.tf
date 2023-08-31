variable service_name {
  type = string
  description = "Name of the service."
  default = "app"
}

variable location {
  type = string
  description = "Location of the service."
  default = "us-central1"
}

variable project_id {
  type = string
  default = null
  description = "Google Cloud project in which to create resources."
}

#variable service_acc {
#  type = string
#}

// --

variable image {
  description = "GCR hosted image URL to deploy"
  type        = string
}

variable cpus {
  type = number
  default = 1
  description = "Number of CPUs to allocate per container."
}

variable memory {
  type = number
  default = 256
  description = "Memory (in Mi) to allocate to containers. Minimum of 512Mi is required when `execution_environment` is `\"gen2\"`."
}

variable ports {
  type = object({
    name = string
    port = number
  })
  default = {
    name = "http1"
    port = 8080
  }
  description = "Port on which the container is listening for incoming HTTP requests.Port which the container listens to (http1 or h2c)"
}

variable labels {
  type = map(string)
  default = {}
  description = "Labels to apply to the service."
}

variable cpu_throttling {
  type = bool
  default = true
  description = "Configure CPU throttling outside of request processing."
}

variable execution_environment {
  type = string
  default = "gen1"
  description = "Execution environment to run container instances under."
}

variable max_instances {
  type = number
  default = 4
  description = "Maximum number of container instances allowed to start."
}

variable min_instances {
  type = number
  default = 1
  description = "Minimum number of container instances to keep running."
}

variable "startup_boost" {
  type = number
  default = 1
}


