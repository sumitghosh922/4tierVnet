# Resource 1 : db subnet

resource "azurerm_subnet" "dbsubnet" {
    name = var.db-subnet-name
    address_prefixes = var.db-address-space
    resource_group_name = var.resource_group_name.name
    virtual_network_name = var.vnet_name.name
  
}

resource "azurerm_network_security_group" "dbnsg" {
    name = "${var.vnet_name}-${var.db-subnet-name}-nsg"
    location = var.resource_group_location.location
    resource_group_name = var.resource_group_name
}

locals {
  db_inbound_ports = {
    "100" : "80",
    "110" : "443",
    "120" : "22"
  }
}
resource "azurerm_network_security_rule" "dbnsgrule" {
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
  network_security_group_name = azurerm_network_security_group.dbnsg.name 
}

resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_association" {
    network_security_group_id = azurerm_network_security_group.dbnsg.id
    subnet_id = azurerm_subnet.dbsubnet.id
  
}