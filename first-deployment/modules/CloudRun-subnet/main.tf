###############################################################################
# Subnet Module
# -----------------------------------------------------------------------------
# main.tf
###############################################################################

# Loop over a map and output a map
# {for <KEY>, <VALUE> in <MAP> : <OUTPUT_KEY> => <OUTPUT_VALUE>}

locals {
  subnets = {
    for x in var.subnets :"${x.subnet_region}/${x.subnet_name}" => x
  }
}


#Subnet configuration
resource "google_compute_subnetwork" "subnetwork" {
  for_each                 = local.subnets 
  name                     = each.value.subnet_name
  ip_cidr_range            = each.value.subnet_ip
  region                   = each.value.subnet_region
  network     = var.network_name
  project     = var.project_id
  description = lookup(each.value, "description", null)   #lookup(map, key, default)
  private_ip_google_access = lookup(each.value, "subnet_private_access", "false")
   
  
#log config 

  dynamic "log_config" {
    for_each = lookup(each.value, "subnet_flow_logs", false) ? [{
      aggregation_interval = lookup(each.value, "subnet_flow_logs_interval", "INTERVAL_5_SEC")
      flow_sampling        = lookup(each.value, "subnet_flow_logs_sampling", "0.5")
      metadata             = lookup(each.value, "subnet_flow_logs_metadata", "INCLUDE_ALL_METADATA")
      filter_expr          = lookup(each.value, "subnet_flow_logs_filter", "true")
    }] : []

    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
      filter_expr          = log_config.value.filter_expr
    }
  }

#Secondary_ranges

  secondary_ip_range = [
    for i in range(
      length(
        contains(
        keys(var.secondary_ranges), each.value.subnet_name) == true
        ? var.secondary_ranges[each.value.subnet_name]
        : []
    )) :
    var.secondary_ranges[each.value.subnet_name][i]
  ]

  purpose = lookup(each.value, "purpose", null)
  role    = lookup(each.value, "role", null)
}
