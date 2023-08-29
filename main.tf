/******************************************
	cloud-run
******************************************/

module "cloud-run" {
  source                  = "./modules/CloudRun-cloud-run"
  location 		  = var.region
  project_id              = var.project_id
  service_name		  = var.cloudrun_instance_name
  #service_acc	          = var.service_acc
  image 		  = "gcr.io/${var.project_id}/app"
}

/******************************************
	firestore
******************************************/

module "firestore" {
  source                  = "./modules/CloudRun-firestore"
  project_id              = var.project_id
  database_type           = "FIRESTORE_NATIVE"
  depends_on = [
    module.cloud-run
  ]
}

/*****************************************
	VPC Subnets
*****************************************/

module "vpc" {
  source                  = "./modules/CloudRun-vpc"
  project_id              = var.project_id
  network_name            = var.vpc_name 
  auto_create_subnetworks = false
}

module "subnet" {
  source       = "./modules/CloudRun-subnet"
  project_id   = var.project_id
  network_name = module.vpc.vpc.self_link
  subnets = [{
    subnet_name           = var.subnet_name
    subnet_region         = var.region
    subnet_ip             = var.subnet_ip_ranges
    subnet_flow_logs      = "false"
    subnet_private_access = "false"
    }]
  depends_on = [
    module.vpc
  ]
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
  cloud_run {
    service  = module.cloud-run.name
  }
  depends_on = [
    module.cloud-run
  ]
}

module "lb-http" {
  source  	= "./modules/CloudRun-http-lb"
  name   	= var.lb_name
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
    module.cloud-run
  ]
}

