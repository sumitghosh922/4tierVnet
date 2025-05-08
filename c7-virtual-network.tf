resource "azurerm_virtual_network" "myvent1" {
    name = var.vnet_name
    location = var.resource_group_location
    address_space = var.vnet_address_space
    resource_group_name = var.resource_group_name
    tags = local.common_tags
}