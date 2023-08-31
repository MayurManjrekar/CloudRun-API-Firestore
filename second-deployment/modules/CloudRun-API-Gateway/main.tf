#resource "google_project_service" "api-gateway" {
#  project = var.project_id
#  service = "apigateway.googleapis.com"
#}

#resource "google_project_service" "service-management" {
#  project = var.project_id
#  service = "servicemanagement.googleapis.com"
#}

#resource "google_project_service" "service-control" {
#  project = var.project_id
#  service = "servicecontrol.googleapis.com"
#}

resource "google_api_gateway_api" "api_gw" {
  provider     = google-beta
  api_id       = var.api_id  #"api-id-tf"
  display_name = var.api_gateway_name  #"API Gateway"
  #depends_on   = [google_project_service.api-gateway , google_project_service.service-management , google_project_service.service-control]
}

resource "google_api_gateway_api_config" "api_cfg" {
  provider      = google-beta
  api           = google_api_gateway_api.api_gw.api_id
  #api_config_id_prefix = "api"
  display_name  = var.config_name   #"Api Config"
  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("spec.yaml")
    }
  }
}

resource "google_api_gateway_gateway" "gw" {
  provider   = google-beta
  region     = var.region

  api_config   = google_api_gateway_api_config.api_cfg.id

  gateway_id   = var.gateway_id
  display_name = var.gateway_name

  depends_on = [google_api_gateway_api_config.api_cfg]
}
