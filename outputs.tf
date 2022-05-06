# server name
output "sql_server_id" {
  description = "The Microsoft SQL Server ID."
  value       = flatten(azurerm_mssql_server.mssql_server.*.id)
}
output "fully_qualified_domain_name" {
  description = "The fully qualified domain name of the Azure SQL Server (e.g. myServerName.database.windows.net)"
  value       = flatten(azurerm_mssql_server.mssql_server.*.name)
}
output "sql_database_id" {
  description = "The ID of the MS SQL Database."
  value       = flatten(azurerm_mssql_database.mssql_database.*.id)
}
output "sql_database_name" {
  description = "The Name of the MS SQL Database."
  value       = flatten(azurerm_mssql_database.mssql_database.*.name)
}
output "encryption_protector_id" {
  description = "The ID of the MSSQL encryption protector"
  value       = flatten(azurerm_mssql_server_transparent_data_encryption.mssql_server_transparent_data_encryption.*.id)
}