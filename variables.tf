# common Variables
variable "resource_group_name" {
  type        = string
  description = "(Required) Name of Resource Group"
}
variable "resource_group_location" {
  type        = string
  description = "(Required) Location where we want to implement code"
}

# variables for SQL Server
variable "sql_server_name" {
  type        = string
  description = "(Required) The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
}
variable "sql_version" {
  type        = string
  description = "(Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
}
variable "administrator_login" {
  type        = string
  description = "(Optional) The administrator login name for the new server. Required unless azuread_authentication_only in the azuread_administrator block is true. When omitted, Azure will generate a default username which cannot be subsequently changed. Changing this forces a new resource to be created."

}
variable "administrator_login_password" {
  type        = string
  description = "(Optional) The password associated with the administrator_login user. Needs to comply with Azure's Password Policy. Required unless azuread_authentication_only in the azuread_administrator block is true."

}
variable "connection_policy" {
  type        = string
  description = "(Optional) The connection policy the server will use. Possible values are Default, Proxy, and Redirect. Defaults to Default."
  default     = "Default"
}
variable "identity" {
  description = "(Optional) An identity block."
  type = object({
    type         = string # (Required) Specifies the type of Managed Service Identity that should be configured on this API Management Service. Possible values are SystemAssigned,.
    identity_ids = string # (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this API Management Service. This is required when type is set to UserAssigned
  })
  default = null
}
variable "azuread_administrator" {
  description = "(Optional) An identity block."
  type = object({
    login_username         = string # (Required) The login username of the Azure AD Administrator of this SQL Server.
    object_id = string # (Required) The object id of the Azure AD Administrator of this SQL Server.
  })
  default = null
}
variable "tenant_id" {
  type        = string
  description = "(Optional) The tenant id of the Azure AD Administrator of this SQL Server."
  default     = null
}
variable "azuread_authentication_only" {
  type        = bool
  description = "(Optional) Specifies whether only AD Users and administrators (like azuread_administrator.0.login_username) can be used to login, or also local database users (like administrator_login). When true, the administrator_login and administrator_login_password properties can be omitted."
  default     = false
}

variable "minimum_tls_version" {
  type        = string
  description = "(Optional) The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: 1.0, 1.1 and 1.2." # Once minimum_tls_version is set it is not possible to remove this setting and must be given a valid value for any further updates to the resource.
  default     = null
}
variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for this server."
  default     = true
}
variable "outbound_network_restriction_enabled" {
  type        = bool
  description = "(Optional) Whether outbound network traffic is restricted for this server."
  default     = false
}

# Variable for MSSQL Database
variable "mssql_database_name" {
  type        = string
  description = "(Required) The name of the Ms SQL Database. Changing this forces a new resource to be created."
}
variable "auto_pause_delay_in_minutes" {
  type        = number
  description = "(Optional) Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases."
  default     = null
}
variable "create_mode" {
  type        = string
  description = "(Optional) The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary."
  default     = null
}
variable "creation_source_database_id" {
  type        = string
  description = "(Optional) The ID of the source database from which to create the new database. This should only be used for databases with create_mode values that use another database as reference. Changing this forces a new resource to be created."
  default     = null
}
variable "collation" {
  type        = string
  description = "(Optional) Specifies the collation of the database. Changing this forces a new resource to be created."
  default     = null
}
variable "elastic_pool_id" {
  type        = string
  description = "(Optional) Specifies the ID of the elastic pool containing this database.."
  default     = null
}

variable "geo_backup_enabled" {
  type        = bool
  description = "(Optional) A boolean that specifies if the Geo Backup Policy is enabled." # geo_backup_enabled is only applicable for DataWarehouse SKUs (DW*). This setting is ignored for all other SKUs.
  default     = false
}
variable "license_type" {
  type        = string
  description = "(Optional) Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice."
  default     = null
}
variable "long_term_retention_policy" {
  description = "(Optional) A long_term_retention_policy block as defined below."
  type = object({
    weekly_retention  = number # (Optional) The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. P1Y, P1M, P1W or P7D.n"
    monthly_retention = number # (Optional) The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. P1Y, P1M, P4W or P30D.
    yearly_retention  = number # (Optional) The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. P1Y, P12M, P52W or P365D.
    week_of_year      = number # (Required) The week of year to take the yearly backup. Value has to be between 1 and 52.
  })
  default = null
}
variable "max_size_gb" {
  type        = number
  description = "(Optional) The max size of the database in gigabytes." # This value should not be configured when the create_mode is Secondary or OnlineSecondary, as the sizing of the primary is then used
  default     = null
}
variable "min_capacity" {
  type        = number
  description = "(Optional) Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases."
  default     = null
}

variable "restore_point_in_time" {
  type        = string
  description = "(Required) Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database. This property is only settable for create_mode= PointInTimeRestore databases."
  default     = null
}
variable "recover_database_id" {
  type        = string
  description = "(Optional) The ID of the database to be recovered. This property is only applicable when the create_mode is Recovery."
  default     = null
}
variable "restore_dropped_database_id" {
  type        = string
  description = "(Optional) The ID of the database to be restored. This property is only applicable when the create_mode is Restore."
  default     = null
}
variable "read_replica_count" {
  type        = number
  description = "(Optional) The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases."
  default     = null
}
variable "read_scale" {
  type        = bool
  description = "(Optional) If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases."
  default     = null
}
variable "sample_name" {
  type        = string
  description = "(Optional) Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT."
  default     = null
}
variable "short_term_retention_policy" {
  description = "(Optional) A short_term_retention_policy block as defined below."
  type = object({
    retention_days = number # (Required) Point In Time Restore configuration. Value has to be between 7 and 35."
  })
  default = null
}
variable "sku_name" {
  type        = string
  description = "(Optional) Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100. Changing this from the HyperScale service tier to another service tier will force a new resource to be created."
  default     = null
}
variable "storage_account_type" {
  type        = string
  description = "(Optional) Specifies the storage account type used to store backups for this database. Changing this forces a new resource to be created. Possible values are GRS, LRS and ZRS. The default value is GRS."
  default     = null
}
variable "threat_detection_policy" {
  description = "(Optional) Threat detection policy configuration."
  type = object({
    state                      = string # (Required) The State of the Policy. Possible values are Enabled, Disabled or New.
    disabled_alerts            = string # (Optional) Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability
    email_account_admins       = bool   # (Optional) Should the account administrators be emailed when this alert is triggered?
    email_addresses            = string # (Optional) A list of email addresses which alerts should be sent to.
    retention_days             = number # (Optional) Specifies the number of days to keep in the Threat Detection audit logs.
    storage_account_access_key = string # (Optional) Specifies the identifier key of the Threat Detection audit storage account. Required if state is Enabled.
    storage_endpoint           = string # (Optional) Specifies the blob storage endpoint. This blob storage will hold all Threat Detection audit logs. Required if state is Enabled.
  })
  default = null
}
variable "zone_redundant" {
  type        = bool
  description = "(Optional) Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases."
  default     = null
}


# Variable for Transparent data encryption
variable "use_key_vault" {
  type        = bool
  description = "(Optional) use customer managed keys from Azure Key Vault?"
  default     = false
}
variable "key_vault_key_id" {
  type        = string
  description = "(Optional) To use customer managed keys from Azure Key Vault, provide the AKV Key ID. To use service managed keys, omit this field."
  default     = null
}
variable "key_vault_key_name" {
  type        = string
  description = "(Optional) Specifies the name of the Key Vault Key."
  default     = null
}
variable "key_vault_id" {
  type        = string
  description = "(Optional) Specifies the ID of the Key Vault instance where the Secret resides"
  default     = null
}


variable "tag_map" {
  type        = map(string)
  description = "Map of Tags those we want to Add"
}


/*------------Private endpoint-------------*/
variable "private_service_connection_name" {
  description = "(Optional) Name of private service connection "
  type        = string
  default     = "mssql-private-connection"
}
variable "private_dns_zone_name" {
  description = "(Optional) Name of private dns zone"
  type        = string
  default     = "privatelink.mssql.windows.net"
}

variable "private_dns_zone_virtual_network_link_name" {
  description = "(Optional) Name of private dns zone_virtual_network_link"
  type        = string
  default     = "private-dns-zone-vnet"
}
variable "enable_private_endpoint" {
  type        = bool
  description = "Enable private endpoint"
}

variable "vnet_name" {
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
  type        = string
  default     = null
}
/*------------------Subnet variable -----------*/
variable "subnet_name" {
  description = "The variable for subnet name"
  type        = string
  default     = null
}