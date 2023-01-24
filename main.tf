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

resource "azurerm_resource_group" "rg1" {
  name = "rg-01"
  location = "eastus"
}

resource "azurerm_virtual_network" "vnet1" {
  name = "azurevnet"
  resource_group_name = azurerm_resource_group.rg1.name
  location = azurerm_resource_group.rg1.location
  address_space = ["10.0.0.0/16"]  
}

resource "azurerm_subnet" "subnet-1" {
  name = "subnet1"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes = [ "10.0.1.0/24" ] 
}

resource "azurerm_subnet" "subnet-2" {
  name = "subnet2"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes = [ "10.0.2.0/24" ]
}
resource "azurerm_subnet" "subnet3" {
  name = "subnet3"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes = [ "10.0.3.0/24" ]  
}

resource "azurerm_virtual_network" "vnet-2" {
  name = "azurevnet-2"
  resource_group_name = azurerm_resource_group.rg1.name
  location = azurerm_resource_group.rg1.location
  address_space = [ "30.0.0.0/16" ]
}

resource "azurerm_subnet" "snet1" {
  name = "subneta"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet-2.name
  address_prefixes = [ "30.0.1.0/24" ]
}

resource "azurerm_subnet" "snet2" {
  name = "subnetb"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet-2.name
  address_prefixes = [ "30.0.2.0/24" ]
}