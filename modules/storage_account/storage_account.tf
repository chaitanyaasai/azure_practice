variable "sa_name" {}
variable "sa_location" {}
variable "sa_resource_group_name" {}

resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  resource_group_name      = var.sa_resource_group_name
  location                 = var.sa_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

output "sa_name" {
  value = azurerm_storage_account.sa.name
}