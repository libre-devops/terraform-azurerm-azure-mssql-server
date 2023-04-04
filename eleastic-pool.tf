resource "azurerm_mssql_elasticpool" "mssql_elastic_pool" {
  count                          = var.add_server_to_elastic_pool == true ? 1 : 0
  name                           = var.sql_server_elastic_pool_name
  resource_group_name            = azurerm_mssql_server.mssql_server.resource_group_name
  location                       = azurerm_mssql_server.mssql_server.location
  server_name                    = azurerm_mssql_server.mssql_server.name
  maintenance_configuration_name = var.elastic_pool_maintenance_configuration_name
  license_type                   = var.elastic_pool_license_type
  max_size_gb                    = var.elastic_pool_max_size_gb
  zone_redundant                 = var.elastic_pool_zone_redundant


  dynamic "sku" {
    for_each = lookup(var.elastic_pool_settings, "sku", {}) != {} ? [1] : []
    content {
      name     = lookup(var.elastic_pool_settings.sku, "name", null)
      tier     = lookup(var.elastic_pool_settings.sku, "tier", null)
      family   = lookup(var.elastic_pool_settings.sku, "family", null)
      capacity = lookup(var.elastic_pool_settings.sku, "capacity", null)
    }
  }

  dynamic "per_database_settings" {
    for_each = lookup(var.elastic_pool_settings, "per_database_settings", {}) != {} ? [1] : []
    content {
      min_capacity = lookup(var.elastic_pool_settings.per_database_settings, "min_capacity", null)
      max_capacity = lookup(var.elastic_pool_settings.per_database_settings, "max_capacity", null)

    }
  }
}