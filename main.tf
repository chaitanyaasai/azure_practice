resource "azurerm_resource_group" "rg" {
  name     = "demo_terraform_rg"
  location = "West Europe"
}

data "azurerm_resource_group" "existing_rg" {
  name = "backend_dev_rg"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "demo_terraform_vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "demo_terraform_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}


///////////////////////////////////////////////////////////////////////////



resource "azurerm_key_vault" "kv" {
  name                        = "demo-terraform-kv"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  //  tenant_id                   = "630dc19a-40be-49e8-9a82-43a424010529"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

//////////////////////////////////////////////////////////////////////////
data "azurerm_client_config" "current" {}


variable "resource_group_name" {}
variable "resource_group_location" {}

module "rg" {
  source       = "./modules/resource_group"
  rg_name1     = var.resource_group_name
  rg_location1 = var.resource_group_location
}

module "vnet" {
  source                    = "./modules/virtual_network"
  vnet_name1                = "module_terraform_vnet1"
  vnet_address_space1       = ["10.0.0.0/16"]
  vnet_location1            = module.rg.rg_location
  vnet_resource_group_name1 = module.rg.resource_name
}

module "subnet" {
  source                       = "./modules/subnet"
  subnet_name                  = "module-subnet1"
  subnet_resource_group_name   = module.rg.resource_name
  subnet_virtual_network_name  = module.vnet.vnet_name
  subnet_address_prefixes      = ["10.0.1.0/24"]
}

module "key_vault" {
  source                        = "./modules/key_vault"
  kv_name                       = "module-kv-001"
  kv_location                   = module.rg.rg_location
  kv_resource_group_name        = module.rg.resource_name
  kv_tenant_id                  = data.azurerm_client_config.current.tenant_id
  kv_rbac_authorization_enabled = false
}

module "storage_account" {
  source                 = "./modules/storage_account"
  sa_name                = "modterraformstorage001"
  sa_location            = module.rg.rg_location
  sa_resource_group_name = module.rg.resource_name
}


