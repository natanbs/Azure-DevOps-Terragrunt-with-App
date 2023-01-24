output "azure_subnet_id" {
    value = {
        for id in keys(var.subnets) : id => azurerm_subnet.subnet[id].id
    }
    description = "Lists the ID's of the subnets"
}

output "virtual_network_name" {
  description = "The Name of the vnet"
  value       = azurerm_virtual_network.vnet.name
}
