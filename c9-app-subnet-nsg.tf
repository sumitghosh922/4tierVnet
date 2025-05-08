#Resource 1 : App subnet

resource "azurerm_subnet" "appsubnet" {
    name = var.app-subnet-name
    resource_group_name = var.resource_group_name
    virtual_network_name = var.vnet_name
    address_prefixes = var.app-address-space
  
}

#resource 2 : app nsg

resource "azurerm_network_security_group" "appnsg" {
    name = "${var.vnet_name}-${var.app-subnet-name}-nsg"
    location = var.resource_group_location
    resource_group_name = azurerm_resource_group.myrg1.name

}

#resouce 3 : network inbound rules

locals {
  app_inbound_rules = {
    "100" : "80",
    "110" : "443",
    "120" : "22"
  }
}

resource "azurerm_network_security_rule" "app_nsg_rules" {
  for_each = local.app_inbound_rules
  name                        = "Port-${each.value}"
  priority                    = each.key
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrg1.name
  network_security_group_name = azurerm_network_security_group.appnsg.name
  
}

#associate sunbet and nsg

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_association" {
    depends_on = [ azurerm_network_security_rule.app_nsg_rules ]
    network_security_group_id = azurerm_network_security_group.appnsg.id
    subnet_id = azurerm_subnet.appsubnet.id
}