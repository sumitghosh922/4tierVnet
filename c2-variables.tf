variable "arm_client_id" {}
variable "arm_client_secret" {}
variable "arm_tenant_id" {}
variable "arm_subscription_id" {}

# Generic Input Variables
# Business Division
variable "business_divsion" {
    description = "Bussiness Devision"
    type = string
    default = "sap"
  }

# Environment Variable
variable "environment" {
    description = "Environment"
    type = string
    default = "dev" 
}
# Azure Resource Group Name 
variable "resource_group_name" {
    description = "resource group name"
    type = string
    default = "my-rg1"
}

#azure resource group location
variable "resource_group_location" {
    description = "resource group location"
    type = string
    default = "eastus"
}