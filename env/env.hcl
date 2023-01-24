locals {
    
  env = "dev"

#   # VNET
#   vnet_cidr = ["10.0.0.0/16"]
#   subnet_names = [
#     # "${local.resource_group}-subnet-app",
#     # "${local.resource_group}-subnet-db"
#     "${var.env_longname}-subnet-app",
#     "${var.env_longname}-subnet-db"
#   ]
#   subnet_prefixes = [
#     "10.0.1.0/24",
#     "10.0.2.0/24"
#   ]
#   subnet_service_endpoints = {
#     (local.subnet_names.0) = [
#       "Microsoft.KeyVault"
#     ],
#     (local.subnet_names.1) = [
#       "Microsoft.Sql",
#       "Microsoft.AzureCosmosDB"
#     ]
#   }
#   enforce_private_link_endpoint_network_policies = [
#     false,
#     true
#   ]
}
