# Create subnet
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  resource_group_name  = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"
  virtual_network_name = "${var.env}-${var.region_name}-${var.project}-${var.instance}-vnet"
  name                 = each.value["name"]
  address_prefixes     = each.value["address_prefixes"] 
}

# Create public IPs
resource "azurerm_public_ip" "pubIP" {
  name                = "${var.env}-${var.region_name}-${var.project}-${var.instance}-pubIP"
  location            = var.region
  resource_group_name = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.env}-${var.region_name}-${var.project}-${var.instance}-nsg"
  location            = var.region
  resource_group_name = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges     = ["22", "5000"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.env}-${var.region_name}-${var.project}-${var.instance}-nic"
  location            = var.region
  resource_group_name = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"
  ip_configuration {
    name                          ="ipConf"
    subnet_id                     = azurerm_subnet.subnet["vm_subnet"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubIP.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsga" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "sa" {
  name                     = "${var.env}${var.region_name}${var.project}${var.instance}sa"
  location                 = var.region
  resource_group_name      = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create (and display) an SSH key
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.env}-${var.region_name}-${var.project}-${var.instance}-vm"
  location              = var.region
  resource_group_name   = "${var.env}-${var.region_name}-${var.project}-${var.instance}-rg"
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_A1_v2"
  tags = {
    environment = var.env
    region      = var.region
    project     = var.project
    instance    = var.instance
  }
  
  os_disk {
    name                 = "${var.env}-${var.region_name}-${var.project}-${var.instance}-osDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "${var.env}-${var.region_name}-${var.project}-${var.instance}-vm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.ssh.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.sa.primary_blob_endpoint
  }

  /* connection {
    type         = "ssh"
    user         = "azureuser"
    # password  = var.root_password 
    private_key  = tls_private_key.ssh.private_key_pem
    host         = azurerm_linux_virtual_machine.vm.public_ip_address
  }
  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE='644' sh -",
      "echo k3s installed",
      "git clone https://github.com/natanbs/App_DevOps_encapsulation.git",
      "cd App_DevOps_encapsulation/v6_pv_pvc_storage",
      "./ping-install.sh"
    ]
  }  */

  /* provisioner "local-exec" {
    inline = [
      "scp -o StrictHostKeyChecking=no azureuser@${self.access_public_ipv4}:/etc/rancher/k3s/k3s.yaml ./",
      "sed -i 's/127.0.0.1/${self.access_public_ipv4}/' k3s.yaml"
    ]    
  } */
}
