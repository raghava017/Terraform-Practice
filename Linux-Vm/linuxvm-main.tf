terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name = "rg-01"
  location = "eastus"
}

resource "azurerm_virtual_network" "example" {
    name = "myvnet"
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    address_space = [ "30.0.0.0/16" ]
}

resource "azurerm_subnet" "example" {
    name = "internal"
    resource_group_name = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes = [ "30.0.1.0/24" ]
}

resource "azurerm_network_interface" "example" {
    name = "azure-nic"
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
    name = "linux-vm1"
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    size = "Standard_B1s"
    admin_username = "adminuser"
    network_interface_ids = [ 
        azurerm_network_interface.example.id,
    ]
admin_ssh_key {
  username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
}
os_disk {
  caching = "ReadWrite"
  storage_account_type = "Standad_LRS"  
  }
source_image_reference {
  publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
}
}