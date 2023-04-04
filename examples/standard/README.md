
```hcl
module "rg" {
  source = "registry.terraform.io/libre-devops/rg/azurerm"

  rg_name  = "rg-${var.short}-${var.loc}-${terraform.workspace}-build" // rg-ldo-euw-dev-build
  location = local.location                                            // compares var.loc with the var.regions var to match a long-hand name, in this case, "euw", so "westeurope"
  tags     = local.tags

  #  lock_level = "CanNotDelete" // Do not set this value to skip lock
}

module "sql" {
  source = "registry.terraform.io/libre-devops/azure-mssql-server/azurerm""

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  sql_admin_username            = "LibreDevOpsAdmin"
  sql_admin_password            = data.azurerm_key_vault_secret.mgmt_local_admin_pwd.value
  sql_server_name               = "sql-${var.short}-${var.loc}-${terraform.workspace}-01"
  public_network_access_enabled = true

  identity_type = "SystemAssigned"

  sql_server_settings = {

    azuread_administrator = {
      login_username              = "lbdoadmin"
      object_id                   = data.azurerm_client_config.current_creds.object_id
      tenant_id                   = data.azurerm_client_config.current_creds.tenant_id
      azuread_authentication_only = false
    }
  }

  add_server_to_elastic_pool = true
  elastic_pool_license_type  = "LicenseIncluded"
  elastic_pool_max_size_gb   = "10"

  elastic_pool_settings = {
    sku = {
      name     = "BasicPool"
      tier     = "Basic"
      family   = "Gen4"
      capacity = "4"
    }

    per_database_settings = {
      min_capacity = 0.25
      max_capacity = 4
    }
  }
}


```
