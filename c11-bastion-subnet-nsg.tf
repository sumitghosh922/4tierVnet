resource "azurerm_subnet" "bastion-subnet" {
    name = var.bastion-subnet-name
    address_prefixes = var.Bastion-address-space
    resource_group_name = var.resource_group_name
    virtual_network_name = var.vnet_name
  
}

resource "azurerm_network_security_group" "bastion-nsg" {
    name = "${var.vnet_name}-${var.bastion-subnet-name}-nsg"
    location = var.resource_group_location
    resource_group_name = var.resource_group_name
}

locals {
  bastion-inbound = {
    "100" : "22", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "3389"
  }
}

## NSG Inbound Rule for Bastion / Management Subnets
resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
  for_each = local.bastion-inbound
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrg1.name
  network_security_group_name = azurerm_network_security_group.bastion-nsg.name
}

# Resource-3: Associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_associate" {
  depends_on = [ azurerm_network_security_rule.bastion_nsg_rule_inbound]    
  subnet_id                 = azurerm_subnet.bastion-subnet.id
  network_security_group_id = azurerm_network_security_group.bastion-nsg.id
}