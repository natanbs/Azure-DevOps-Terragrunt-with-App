variable "resource_group" {
  type        = string
  description = "The name of the resource group"
}

# variable "tags" {
#   type        = map(string)
#   description = "Tags used for the deployment"
#   default = {
#     "Environment" = "Lab"
#     "Owner"       = "<name>"
#   }
# }

variable "project" {
  type        = string
  description = "The project of the deployment"
}

variable "env" {
  type        = string
  description = "The project of the deployment"
}

variable "instance" {
  type        = string
  description = "The instance of the deployment"
}

variable "region" {
  type        = string
  description = "The region for the deployment"
}

variable "region_name" {
  type        = string
  description = "The short region name"
}

variable "vnet_name" {
  type        = string
  description = "The name of the vnet"
  default     = "<vnet name>"
}

variable "vnet_address_space" {
  type        = list(any)
  description = "the address space of the VNet"
  default     = ["10.13.0.0/16"]
}

variable "subnets" {
  type = map(any)
  default = {
    subnet_1 = {
      name             = "subnet_1"
      address_prefixes = ["10.13.1.0/24"]
    }
    subnet_2 = {
      name             = "subnet_2"
      address_prefixes = ["10.13.2.0/24"]
    }
    subnet_3 = {
      name             = "subnet_3"
      address_prefixes = ["10.13.3.0/24"]
    }
    # The subnet of the vm
     /* vm_subnet = {
       name             = "vmSubnet"
       address_prefixes = ["10.13.250.0/24"]
    } */
  }
}

