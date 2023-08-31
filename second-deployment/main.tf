/******************************************
	API Gateway
******************************************/

module "api-gateway" {
  source            = "./modules/CloudRun-API-Gateway"
  region 		        = var.region
  project_id        = var.project_id
  api_gateway_name	= var.api_gateway_name  #"Bookshelf API Gateway"
  api_id		        = var.api_id            #"bookshelf-api-id"
  config_name		    = var.config_name	      #"Bookshelf API Config"
  gateway_id		    = var.gateway_id        #"bookshelf-gateway-id"
  gateway_name		  = var.gateway_name      #"Bookshelf Gateway"
}

/******************************************
	external-lb-http
******************************************/

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  name                  = var.neg_name
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  project               = var.project_id
  serverless_deployment  {
    platform   = "apigateway.googleapis.com"
    resource   = var.gateway_id             #"bookshelf-gateway-id"
  }
  depends_on = [
    module.api-gateway
  ]
}

module "lb-http" {
  source  	= "./modules/CloudRun-http-lb"
  name     	= var.lb_name
  project 	= var.project_id

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn = false

      iap_config = {
        enable = false
      }
      log_config = {
        enable = false
      }
    }
  }
  depends_on = [
    google_compute_region_network_endpoint_group.serverless_neg
  ]
}

