provider "azurerm" {
  subscription_id = "6f882cde-0dd4-4e6d-9e62-09ccc96c786a"
  features {}
}

resource "azurerm_resource_group" "apprg" {
  name     = "${var.name}-rg"
  location = "Central US"
}
resource "azurerm_virtual_network" "network" {
  name                = "${var.name}-vnet"
  address_space       = ["10.255.240.0/23"]
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name
}
resource "azurerm_subnet" "appsubnet" {
  name                 = "${var.name}-app-subnet"
  resource_group_name  = azurerm_resource_group.apprg.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.255.240.0/24"]
}
resource "azurerm_network_security_group" "appsubnetnsg" {
  name                = "${var.name}-app-nsg"
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name
}
resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.appsubnetnsg.id
}
resource "azurerm_network_security_rule" "http-in" {
  name                        = "http-in"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.apprg.name
  network_security_group_name = azurerm_network_security_group.appsubnetnsg.name
}
resource "azurerm_network_security_rule" "ssh-in" {
  name                        = "ssh-in"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.apprg.name
  network_security_group_name = azurerm_network_security_group.appsubnetnsg.name
}