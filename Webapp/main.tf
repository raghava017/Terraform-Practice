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
    name            = "practice"          
    location        = "East US"  
}

resource "azurerm_service_plan" "example" {
    name            = "myplan"
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    os_type = "Linux"
    sku_name = "B1"
}

resource "azurerm_linux_web_app" "example" {
    name = "mywebapp25012023"
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    service_plan_id = azurerm_service_plan.example.id
    site_config {}
}

resource "azurerm_app_service_source_control" "example" {
    app_id = azurerm_linux_web_app.example.id
    repo_url = "https://github.com/Azure-Samples/python-docs-hello-world"
    branch = "master" 
}