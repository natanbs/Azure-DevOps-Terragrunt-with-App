variable "resource_group" {
  description = "The name of the resource group in which to create the storage account"
}

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

variable "description" {
  default = ""
}
