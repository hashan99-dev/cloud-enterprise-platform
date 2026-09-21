terraform {
  required_version = ">= 1.7.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  project_name = "enterprise-core"
  environment  = "dev"
  location     = "uaenorth" # Regional residency focus (Dubai)
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.project_name}-${local.environment}"
  location = local.location

  tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
    Project     = local.project_name
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${local.project_name}-${local.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]

  tags = azurerm_resource_group.main.tags
}