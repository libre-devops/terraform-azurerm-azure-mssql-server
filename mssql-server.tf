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
  tags                                 = var.tags

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