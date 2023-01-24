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

resource "azurerm_resource_group" "rg" {
  name = "${var.rgname}"
  location = "${var.rglocation}"
}

resource "azurerm_virtual_network" "vnet" {
    name = "${var.prefix}-10"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    location = "${azurerm_resource_group.rg.location}"
    address_space = [ "${var.vnet_cidr_prefix}" ]
}

resource "azurerm_subnet" "subnet1" {
    name = "subnet1"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.rg.name}"
    address_prefixes = [ "${var_subnet_cidr_prefix}" ]
}

resource "azurerm_network_interface" "example" {
    name = "azure-nic"
    location = "${azurerm_resource_group.rg.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
    name = "winserver"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    location = "${azurerm_resource_group.rg.location}"
    size = "Standard_B1s"
    admin_username = "Adminuser"
    admin_password = "Password@1234"
    network_interface_ids = [
        azurerm_network_interface.example.id,
    ]
    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}