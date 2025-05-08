resource "azurerm_resource_group" "myrg1" {
    name = "${local.resource_prefix}-${var.resource_group_name}-${random_string.myrandom}"
    location = var.resource_group_location
    tags = local.common_tags
  
}