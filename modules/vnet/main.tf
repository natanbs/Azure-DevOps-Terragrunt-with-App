/* terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
} */

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.env}-${var.region_name}-${var.project}-${var.instance}-vnet"
  address_space       = var.vnet_address_space
  location            = var.region
  resource_group_name = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"
  tags = {
    environment = var.env
    region      = var.region
    project     = var.project
    instance    = var.instance
  }
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  resource_group_name  = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = each.value["name"]
  address_prefixes     = each.value["address_prefixes"]
}
