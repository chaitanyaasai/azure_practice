variable "vnet_name1" {}
variable "vnet_location1" {}
variable "vnet_resource_group_name1" {}
variable "vnet_address_space1" {}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet_name1
  location            = var.vnet_location1
  resource_group_name = var.vnet_resource_group_name1
  address_space       = var.vnet_address_space1
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet1.name
}