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

  subscription_id   = "3de9abff-3086-4829-bb65-654e3402ab17"
  client_id         = "876d68c1-d8e4-447e-aa6c-8670057b4613"
  client_secret     = "QYn8Q~SF~4RenBtH2OdxvLI86~sa.gjNheIfzcSv"
  tenant_id         = "110150fb-d74e-4ec1-b812-2c47af434e86"
 
}

resource "azurerm_resource_group" "example" {
  name = "rg-01"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
    name = "vnet-vmss"
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    address_space = [ "10.0.0.0/16" ]
}

resource "azurerm_subnet" "subnet" {
    name = "internal"
    resource_group_name = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes = [ "10.0.2.0/24" ]
}

resource "azurerm_windows_virtual_machine_scale_set" "example" {
    name = "winvmss"
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    sku = "Standard_B1s"
    instances = 2
    admin_username = "adminuser"
    admin_password = "admin@1234@1234"

    source_image_reference {
       publisher = "MicrosoftWindowsServer"
       offer     = "WindowsServer"
       sku       = "2019-Datacenter"
       version   = "latest"
}

os_disk {
    storage_account_type = "Standard_LRS"
    caching = "ReadWrite"
}
network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet.id
    }
  }
}