<div align = "center">
<H2> Two-Tier-CloudRun-Firestore </H2>
<img alt="cloudrun final design" src="https://github.com/GBG-COE/two-tier-cloudrun-firestore/assets/126166199/8bc54677-9c14-4226-8715-1bb0f891e9e5">

</div>
<div align = "justify">
This design pattern based on Cloud Run with an External HTTP Load Balancer and Firestore as a database. Cloud Run service is used to deploy the appplication and the Firestore database type is Firestore Native.
</div>

## Components Deployed

| Name | Description | Module Hyperlink |
|------|-------------|------------------|
| VPC | Facilitates networking functionality. | [VPC](https://github.com/GBG-COE/Cloud_Factory_Engine_Modules/tree/main/modules/CloudRun-vpc) |
| Subnet | creates CIDR under Vpc. | [Subnet](https://github.com/GBG-COE/Cloud_Factory_Engine_Modules/tree/main/modules/CloudRun-subnet) |
| CloudRun | Cloud Run is a managed compute platform that run containers directly. | [CloudRun](https://github.com/GBG-COE/Cloud_Factory_Engine_Modules/tree/main/modules/CloudRun-cloud-run) |
| Firestore | Firestore is a serverless, NoSQL document database. | [Firestore](https://github.com/GBG-COE/Cloud_Factory_Engine_Modules/tree/main/modules/CloudRun-firestore) |
| External Load Balancer (HTTP) | This is the classic external Application Load Balancer that is global in Premium with cloud run as a backend. | [External Load Balancer](https://github.com/GBG-COE/Cloud_Factory_Engine_Modules/tree/main/modules/CloudRun-http-lb) |
| Network Endpoint Group (serverless) | Serverless NEG | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The GCP project. | `string` | n/a | yes |
| region | The GCP region to create resources in. | `string` | `us-central1` | yes |
| state_bucket_name | tfstate bucket name. | `string` | n/a | yes |
| cloudrun_name | Cloud Run service name. | `string` | n/a | yes |
| vpc_name | Name for the created VPC. | `string` | n/a | yes |
| subnet_name | Name for the created Subnet within the VPC. | `string` | n/a | yes |
| subnet_ip_ranges | IP ranges for the created subnet. | `string` | n/a | yes |
| neg_name | Name for the created serverless NEG. | `string` | n/a | yes |
| lb_name | Name for the created External Load Balancer. | `string` | n/a | yes |


# Github Actions Workflow Description 

The Github Actions Workflow [Two-Tier-Infra-Deployment.yaml](https://github.com/GBG-COE/two-tier-cloudrun-firestore/blob/main/.github/workflows/Two-Tier-Infra-Deployment.yaml) has three jobs to be executed : 

1. Job 1: ``Terraform Bootstrap``
   In this a storage bucket would be created to store the terraform state files.

2. Job 2: ``Image_Build``
   During this step a docker image of the application would be build and pushed to Google Container Registry.

3. Job 3: ``Terraform Apply``
   This stage consist of building the required infrastructure.

Note: The application to be deployed on Cloud Run is included in the work flow , with job name ``Image_Build``. Update `Project_id` within the workflow


## Setup :

# Prerequisite:

- Cloud bucket to store Tfstate and that is automated in github actions workflow 
- If bucket exist changed  ``` bucket_exist = true ``` in ``Bootstrap/terraform.tfvars``
- If not exist changed  ``` bucket_exist = false```  in ``Bootstrap/terraform.tfvars``


# Github Actions Workflow

Note: In this use case we are using vault to store our credentials.

1. Configure Github actions secrets for ``VAULT_ADDR``

2. Configure  `terraform.tfvars` 
```
Project_id      = <Enter Project ID>
Region          = <Enter Region>
cloudrun_name   = <Enter Cloud Run service name>
vpc_name        = <Enter Network name>
subnet_name     = <Enter Sub Network name>
subnet_ip_ranges= <Enter Sub Network IP range>
neg_name        = <Enter NEG name>
lb_name         = <Enter Load Balancer name>
```

3. Run Github workflow  `Two-Tier-CloudRun-Firestore` 


# Through CloudShell

1. Configure  `terraform.tfvars` 
```
Project_id      = <Enter Project ID>
Region          = <Enter Region>
cloudrun_name   = <Enter Cloud Run service name>
vpc_name        = <Enter Network name>
subnet_name     = <Enter Sub Network name>
subnet_ip_ranges= <Enter Sub Network IP range>
neg_name        = <Enter NEG name>
lb_name         = <Enter Load Balancer name>
```

2. Run Terraform commands
```
terraform init

terraform validate

terraform plan

terraform apply
```

## Deployment Strategy 
Note : For implementing deployment strategy refer [two-tier-infra-linux-sql](https://github.com/GBG-COE/two-tier-infra-linux-sql)

There are two environments  ``prod`` and ``non-prod``  for each env there is seperate tfstate bucket to completely isolate two env from each other

- PROD : 
    - main.tf , backends.tf for production environment configurations 
    - terraform.ftvars needs to be configure.
- NON-PROD : 
    -  main.tf , backends.tf for non-production environment 
    - terraform.ftvars needs to be configure.

