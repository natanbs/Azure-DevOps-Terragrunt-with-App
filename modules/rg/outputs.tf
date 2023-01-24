output "resource_group_id" {
  description = "The ID of the newly created RG"
  value       = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  description = "The Name of the newly created RG"
  value       = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"
}

output "resource_group_location" {
  description = "The location of the newly created RG"
  value       = azurerm_resource_group.rg.location
}
