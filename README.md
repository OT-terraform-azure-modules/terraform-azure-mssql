Terraform module which creates MSSQL Server and MSSQL Database.


Terraform versions
------------------
Terraform v1.1.7

Usage
-----
```hcl
module "mssql" {
  source                  = "../../"
  resource_group_name     = "_"
  resource_group_location = "_"

  # Creating mssql server
  sql_server_name              = "_"
  sql_version                  = "_"
  administrator_login          = "_"
  administrator_login_password = "_"
  minimum_tls_version          = "_"

  connection_policy                    = "_"
  public_network_access_enabled        = "_"
  outbound_network_restriction_enabled = "_"
  tag_map                     = "_"
}

resource "azurerm_mssql_database" "mssql_database" {
  name                = "_"
  server_id           = "_"
  sku_name            = "_"

  auto_pause_delay_in_minutes = "_"
  max_size_gb                 = "_"
  min_capacity                = "_"
  read_replica_count          = "_"
  read_scale                  = "_"
  zone_redundant              = "_"
  tags                        = "_"
  create_mode                 = "_"
  creation_source_database_id = "_"
  collation                   = "_"
  elastic_pool_id             = "_"
  geo_backup_enabled          = "_"
  license_type                = "_"
  sample_name                 = "_"
  storage_account_type        = "_"

resource "azurerm_mssql_server_transparent_data_encryption" "mssql_server_transparent_data_encryption" {
  server_id = "_"
  # key_vault_key_id = "_"
}
```

Resources
------
| Name | Type |
|------|------|
| [azurerm_mssql_server.mssql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server) | resource |
| [azurerm_mssql_database.mssql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_database) | resource |
| [azurerm_mssql_server_transparent_data_encryption.mssql_server_transparent_data_encryption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_transparent_data_encryption) | resource |

Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Exesting Resource Group | `string` |  | yes |
| resource_group_location | Location where we want to implement code | `string` |  | yes |
| sql_server_name |  The name of the Microsoft SQL Servere | `string` |  | No |
| sql_version |  The name of the Microsoft SQL Servere | `string` |  | Yes |
| administrator_login |  The administrator login name for the new server | `string` |  | No |
| administrator_login_password |  The password associated with the administrator_login user | `string` |  | No |
| connection_policy |   The connection policy the server will use | `string` | "Default" | No |
| minimum_tls_version |  The Minimum TLS Version for all SQL Database | `string` |  | No |
| public_network_access_enabled |  Whether public network access is allowed for this server | `bool` | true | No |
| outbound_network_restriction_enabled | Whether outbound network traffic is restricted for this server | `bool` | false | No |
| mssql_database_name |  The name of the Microsoft SQL Servere | `string` |  | Yes |
| auto_pause_delay_in_minutes |  Time in minutes after which database is automatically paused | `number` |  | No |
| create_mode |  The create mode of the database | `string` |  | No |
| creation_source_database_id |   The ID of the source database from which to create the new database | `string` |  | No |
| collation |   Specifies the collation of the database | `string` |  | No |
| elastic_pool_id |  Specifies the ID of the elastic pool containing this database | `string` |  | No |
| geo_backup_enabled |  Specifies if the Geo Backup Policy is enabled | `bool` | false | No |
| license_type |   Specifies the license type applied to this database | `string` |  | No |
| max_size_gb | The max size of the database in gigabytes | `number` |  | No |
| min_capacity | Minimal capacity that database will always have allocated, if not paused | `number` |  | No |
| restore_point_in_time | Specifies the point in time | `string` |  | No |
| recover_database_id | The ID of the database to be recovered | `string` |  | No |
| restore_dropped_database_id | The ID of the database to be restored | `string` |  | No |
| read_replica_count | The number of readonly secondary replicas associated with the database | `number` |  | No |
| read_scale | If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica | `bool` |  | No |
| sample_name | Specifies the name of the sample schema to apply when creating this database | `string` |  | No |
| sku_name | Specifies the name of the SKU used by the database | `string` |  | No |
| storage_account_type | Specifies the storage account type used to store backups for this database | `string` |  | No |
| zone_redundant | Whether or not this database is zone redundant | `bool` |  | No |
| key_vault_key_id |  To use customer managed keys from Azure Key Vault | `string` |  | No |
| tag_map | Map of Tags those we want to Add | `map(string)` |  | No |

Output
------
| Name | Description |
|------|-------------|
| sql_server_id | Id's of SQL servers |
| sql_server_name | Name of SQL Servers |
| sql_database_id | Id's of Database |
| sql_database_name | Name of Database |


## Related Projects

Check out these related projects.
--------------------------------
[Azure reource group](https://github.com/OT-terraform-azure-modules/terraform-azure-resource-group)


### Contributors
|  [![Akash Banerjee][Akash_avatar]][Akash.s_homepage]<br/>[Akash Banerjee][Akash.s_homepage] |
|---|
 
  [Akash.s_homepage]:https://github.com/401-akash
  [Akash_avatar]: https://gitlab.com/uploads/-/system/user/avatar/10949531/avatar.png?width=400