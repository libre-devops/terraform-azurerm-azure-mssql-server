#tfsec:ignore:azure-database-enable-audit
resource "azurerm_mssql_server" "mssql_server" {
  name                                 = var.sql_server_name
  resource_group_name                  = var.rg_name
  location                             = var.location
  version                              = var.sql_server_version
  administrator_login                  = var.sql_admin_username
  administrator_login_password         = var.sql_admin_password
  minimum_tls_version                  = try(var.minimum_tls_version, "1.2")
  tags                                 = var.tags
  public_network_access_enabled        = try(var.public_network_access_enabled, false)
  outbound_network_restriction_enabled = try(var.outbound_network_restriction_enabled, false)
  primary_user_assigned_identity_id    = try(var.primary_user_assigned_identity_id, null)

  dynamic "azuread_administrator" {
    for_each = lookup(var.sql_server_settings, "azuread_administrator", null) != {} ? [1] : []
    content {
      login_username              = lookup(var.sql_server_settings.azuread_administrator, "login_username", null)
      object_id                   = lookup(var.sql_server_settings.azuread_administrator, "object_id", null)
      tenant_id                   = lookup(var.sql_server_settings.azuread_administrator, "tenant_id", null)
      azuread_authentication_only = lookup(var.sql_server_settings.azuread_administrator, "azuread_authentication_only", false)
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned" ? [var.identity_type] : []
    content {
      type = var.identity_type
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned, UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) > 0 || var.identity_type == "UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
    }
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "audit_policy" {
  count                                   = var.enable_audit_policy == true ? 1 : 0
  server_id                               = azurerm_mssql_server.mssql_server.id
  storage_endpoint                        = var.audit_policy_storage_endpoint
  storage_account_access_key              = var.audit_policy_storage_key
  storage_account_access_key_is_secondary = var.audit_policy_storage_is_secondary_access_key
  retention_in_days                       = var.audit_policy_retention_in_days
}
