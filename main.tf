provider "azurerm" {
  features {}
}

variable "region" {
  type        = string
  default     = "eastus"
}

variable "resource_group" {
  type        = string
  default     = "rocket-chat-containers-resource-group"
}

resource "azurerm_resource_group" "resource_group" {
  location = var.region
  name     = var.resource_group
}

resource "azurerm_container_registry" "container_registry" {
  name                     = "ai2ccohort04rcmregistry"
  location                 = var.region
  resource_group_name      = var.resource_group
  sku                      = "Standard"
  admin_enabled            = true
}

resource "azurerm_container_group" "container_group" {
  name                = "rocket-chat-container-group"
  location            = var.region
  resource_group_name = var.resource_group
  os_type             = "Linux"

  container {
    name   = "elasticsearch"
    image  = "${azurerm_container_registry.container_registry.login_server}/elasticsearch:39"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = {
    environment = "testing"
  }
}
