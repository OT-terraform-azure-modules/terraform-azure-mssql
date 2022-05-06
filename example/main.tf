# Provider
provider "azurerm" {
  features {}
}

module "mssql" {
  source = "../"
  
  resource_group_name     = "akash_rg"
  resource_group_location = "eastus"
  sql_server_name         = "mssql-server-test-65465876"
  sql_version             = "12.0"
  # minimum_tls_version                  = "1.2"
  public_network_access_enabled        = false
  outbound_network_restriction_enabled = true
  enable_private_endpoint              = true
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIstest1"

  # Required when enable_private_endpoint is true
  vnet_name = "test_vnet"
  subnet_name = "subnet1"

  use_key_vault = false

  # Creating mssql Database
  mssql_database_name = "mssql-database-test-65465876"
  sku_name            = "GP_S_Gen5_2"

  auto_pause_delay_in_minutes = 60
  max_size_gb                 = 100
  min_capacity                = 0.5
  read_replica_count          = 0
  zone_redundant              = false
  read_scale                  = false
  tag_map = {
    name = "mssql"
  }
}