variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

/* variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
} */

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

variable "subnets" {
  type = map(any)
  default = {
    vm_subnet = {
      name             = "vmSubnet"
      address_prefixes = ["10.13.250.0/24"]
    }
  }
}