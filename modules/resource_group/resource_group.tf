variable "rg_name1" {}
variable "rg_location1"{}

resource "azurerm_resource_group" "rg1" {
  name     = var.rg_name1
  location = var.rg_location1
}

output "resource_name" {
  value = azurerm_resource_group.rg1.name
}

output "rg_location"{
  value = azurerm_resource_group.rg1.location
}

output "rg_id"{
  value = azurerm_resource_group.rg1.id
}
