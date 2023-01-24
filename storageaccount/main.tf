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
    name        = "practice"
    location    = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "practicestorage012423"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
