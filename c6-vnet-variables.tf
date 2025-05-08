variable "vnet_name" {
    description = "Vnet Name"
    type = string
    default = "Myvnet"
}

variable "vnet_address_space" {
  description = "Vnet Address Space"
  type = list(string)
  default = [ "10.0.0.0/16" ]
}

#web-app vnet

variable "web-app-subnet-name" {
    description = "Web App subnet name"
    type = string
    default = "webAppSubnetName"
  
}

variable "web-app-address-space" {
    description = "Web App address space"
    type = list(string)
    default = [ "10.0.1.0/24" ]
  
}

#App subnet name

variable "app-subnet-name" {
    description = "App subnet name"
    type = string
    default = "AppSubnetName"
  
}

variable "app-address-space" {
    description = "App Address space"
    type = list(string)
    default = [ "10.0.11.0/24" ]
  
}

#db subnet name

variable "db-subnet-name" {
    description = "DB Subnet Name"
    type = string
    default = "DbSubnetName"
  
}

variable "db-address-space" {
    description = "DB Address space"
    type = list(string)
    default = [ "10.0.21.0/24" ]
  
}

#Bastion subnet name

variable "bastion-subnet-name" {
    description = "Bastion Subnet Name"
    type = string
    default = "BastionSubnetName"
  
}

variable "Bastion-address-space" {
    description = "Bastion Address Space"
    type = list(string)
    default = [ "10.0.100.0/24" ]
  
}