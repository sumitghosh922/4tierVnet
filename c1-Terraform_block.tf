terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
    features {}
    client_id = var.arm_client_id
    client_secret = var.arm_client_secret
    tenant_id = var.arm_tenant_id
    subscription_id = var.arm_subscription_id
}