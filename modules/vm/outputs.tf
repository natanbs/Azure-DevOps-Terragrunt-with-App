output "resource_group_name" {
  value = "${var.env}-${var.region_name}-${var.instance}-rg"
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "tls_private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}
