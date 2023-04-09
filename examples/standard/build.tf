module "rg" {
  source = "registry.terraform.io/libre-devops/rg/azurerm"

  rg_name  = "rg-${var.short}-${var.loc}-${terraform.workspace}-build" // rg-ldo-euw-dev-build
  location = local.location                                            // compares var.loc with the var.regions var to match a long-hand name, in this case, "euw", so "westeurope"
  tags     = local.tags

  #  lock_level = "CanNotDelete" // Do not set this value to skip lock
}

// This module does not consider for CMKs and allows the users to manually set bypasses
#checkov:skip=CKV2_AZURE_1:CMKs are not considered in this module
#checkov:skip=CKV2_AZURE_18:CMKs are not considered in this module
#checkov:skip=CKV_AZURE_33:Storage logging is not configured by default in this module
#tfsec:ignore:azure-storage-queue-services-logging-enabled tfsec:ignore:azure-storage-allow-microsoft-service-bypass #tfsec:ignore:azure-storage-default-action-deny
module "sa" {
  source = "registry.terraform.io/libre-devops/storage-account/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  storage_account_name            = "st${var.short}${var.loc}${terraform.workspace}01"
  access_tier                     = "Hot"
  identity_type                   = "SystemAssigned"
  allow_nested_items_to_be_public = true

  storage_account_properties = {

    // Set this block to enable network rules
    network_rules = {
      default_action = "Allow"
    }

    blob_properties = {
      versioning_enabled       = false
      change_feed_enabled      = false
      default_service_version  = "2020-06-12"
      last_access_time_enabled = false

      deletion_retention_policies = {
        days = 10
      }

      container_delete_retention_policy = {
        days = 10
      }
    }

    routing = {
      publish_internet_endpoints  = false
      publish_microsoft_endpoints = true
      choice                      = "MicrosoftRouting"
    }
  }
}


module "sql" {
  source = "registry.terraform.io/libre-devops/azure-mssql-server/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  sql_admin_username            = "LibreDevOpsAdmin"
  sql_admin_password            = data.azurerm_key_vault_secret.mgmt_local_admin_pwd.value
  sql_server_name               = "sql-${var.short}-${var.loc}-${terraform.workspace}-01"
  public_network_access_enabled = true

  identity_type                 = "SystemAssigned"
  enable_audit_policy           = true
  audit_policy_storage_endpoint = module.sa.sa_primary_blob_endpoint
  audit_policy_storage_key      = module.sa.sa_primary_access_key

  sql_server_settings = {

    azuread_administrator = {
      login_username              = "lbdoadmin"
      object_id                   = data.azurerm_client_config.current_creds.object_id
      tenant_id                   = data.azurerm_client_config.current_creds.tenant_id
      azuread_authentication_only = false
    }
  }

  add_server_to_elastic_pool   = true
  sql_server_elastic_pool_name = "sqlelp-${var.short}-${var.loc}-${terraform.workspace}-01"
  elastic_pool_max_size_gb     = "4.8828125"

  elastic_pool_settings = {
    sku = {
      name     = "BasicPool"
      tier     = "Basic"
      capacity = "50"
    }

    per_database_settings = {
      min_capacity = 0
      max_capacity = 5
    }
  }
}

