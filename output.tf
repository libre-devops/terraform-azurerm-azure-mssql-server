output "elastic_pool_id" {
  value       = var.add_server_to_elastic_pool == true ? azurerm_mssql_elasticpool.mssql_elastic_pool[0].id : null
  description = "The ID of the elastic pool, if one is provisoned"
}

output "sql_server_admin_password" {
  value       = azurerm_mssql_server.mssql_server.administrator_login_password
  description = "The password of the SQL server"
  sensitive   = true
}

output "sql_server_admin_username" {
  value       = azurerm_mssql_server.mssql_server.administrator_login
  description = "The username of the SQL server"
  sensitive   = true
}

output "sql_server_fqdn" {
  value       = azurerm_mssql_server.mssql_server.fully_qualified_domain_name
  description = "The FQDN of the sql server"
}

output "sql_server_id" {
  value       = azurerm_mssql_server.mssql_server.id
  description = "The ID of the SQL Server"
}

output "sql_server_identity" {
  value       = azurerm_mssql_server.mssql_server.identity
  description = "The identity block of the SQL Server"
}

output "sql_server_name" {
  value       = azurerm_mssql_server.mssql_server.name
  description = "The name of the SQL Server"
}
