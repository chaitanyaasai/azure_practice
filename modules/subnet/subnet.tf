variable "subnet_name" {}
variable "subnet_resource_group_name" {}
variable "subnet_virtual_network_name" {}
variable "subnet_address_prefixes" {}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.subnet_resource_group_name
  virtual_network_name = var.subnet_virtual_network_name
  address_prefixes     = var.subnet_address_prefixes
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}