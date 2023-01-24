resource "azurerm_resource_group" "rg" {
#   name     = var.resource_group
  name = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"
  location = var.region

  tags = {
    environment = var.env
    region      = var.region
    project     = var.project
    instance    = var.instance
  }
}
