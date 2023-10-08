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

variable "container_registry" {
  type        = string
  default     = "ai2ccohort04rcmregistry"
}

resource "azurerm_container_group" "container_group" {
  name                = "rocket-chat-container-group"
  location            = var.region
  resource_group_name = var.resource_group
  os_type             = "Linux"

  container {
    name   = "elasticsearch"
    image  = "${var.container_registry}/elasticsearch:39"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 9200
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
  }
}
