data "azurerm_key_vault_key" "key_vault_key" {
  count        = var.use_key_vault ? 1 : 0
  name         = var.key_vault_key_name
  key_vault_id = var.key_vault_id
}
resource "azurerm_mssql_server_transparent_data_encryption" "mssql_server_transparent_data_encryption" {
  server_id        = azurerm_mssql_server.mssql_server.id
  key_vault_key_id = var.use_key_vault ? data.azurerm_key_vault_key.key_vault_key[0].id : null
}