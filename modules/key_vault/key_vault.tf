variable "kv_name" {}
variable "kv_location" {}
variable "kv_resource_group_name" {}
variable "kv_tenant_id" {}
variable "kv_rbac_authorization_enabled" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.kv_location
  resource_group_name         = var.kv_resource_group_name
  tenant_id                   = var.kv_tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  rbac_authorization_enabled  = var.kv_rbac_authorization_enabled
}

output "kv_name" {
  value = azurerm_key_vault.kv.name
}