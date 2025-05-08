#Resource-1: Create WebTier Subnet
resource "azurerm_subnet" "websubnet"{
    name = "${var.vnet_name}-${var.web-app-subnet-name}"
    resource_group_name = azurerm_resource_group.myrg1
    virtual_network_name = azurerm_virtual_network.myvent1
    address_prefixes = var.web-app-address-space  
}

# Resource-2: Create Network Security Group (NSG)
resource "azurerm_network_security_group" "web_nsg" {
  name = "${var.vnet_name}-${var.web-app-subnet-name}-nsg"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name

}

# Resource-3: Associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "web_subent_nsg_association" {
    depends_on = [ azurerm_network_security_rule.example ]
    network_security_group_id = azurerm_network_security_group.web_nsg.id
    subnet_id = azurerm_subnet.websubnet.id
}

# Resource-4: Create NSG Rules
## Locals Block for Security Rules

locals {
  web_inbound_ports = {
    "100" : "80",
    "110" : "443",
    "120" : "22"
  }
}
## NSG Inbound Rule for WebTier Subnet 
resource "azurerm_network_security_rule" "example" {
  for_each = local.web_inbound_ports
  name                        = "port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrg1.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

