resource "azurerm_mssql_database" "mssql_database" {
  name      = var.mssql_database_name
  server_id = azurerm_mssql_server.mssql_server.id
  sku_name  = var.sku_name

  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  max_size_gb                 = var.max_size_gb
  min_capacity                = var.min_capacity
  read_replica_count          = var.read_replica_count
  read_scale                  = var.read_scale # for Premium and Business Critical databases
  zone_redundant              = var.zone_redundant
  tags                        = var.tag_map

  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  collation                   = var.collation
  elastic_pool_id             = var.elastic_pool_id
  geo_backup_enabled          = var.geo_backup_enabled
  license_type                = var.license_type
  restore_point_in_time       = var.restore_point_in_time       # create_mode= PointInTimeRestore databases.
  recover_database_id         = var.recover_database_id         # create_mode is Recovery.
  restore_dropped_database_id = var.restore_dropped_database_id # create_mode is Restore.
  sample_name                 = var.sample_name
  storage_account_type        = var.storage_account_type # Possible values are GRS, LRS and ZRS

  dynamic "threat_detection_policy" {
    for_each = var.threat_detection_policy != null ? [var.identity] : []
    content {
      state                      = var.threat_detection_policy.state
      disabled_alerts            = var.threat_detection_policy.disabled_alerts
      email_account_admins       = var.threat_detection_policy.email_account_admins
      email_addresses            = var.threat_detection_policy.email_addresses
      retention_days             = var.threat_detection_policy.retention_days
      storage_account_access_key = var.threat_detection_policy.storage_account_access_key
      storage_endpoint           = var.threat_detection_policy.storage_endpoint
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = var.long_term_retention_policy != null ? [var.long_term_retention_policy] : []
    content {
      weekly_retention  = var.long_term_retention_policy.weekly_retention
      monthly_retention = var.long_term_retention_policy.monthly_retention
      yearly_retention  = var.long_term_retention_policy.yearly_retention
      week_of_year      = var.long_term_retention_policy.week_of_year
    }
  }
  dynamic "short_term_retention_policy" {
    for_each = var.short_term_retention_policy != null ? [var.short_term_retention_policy] : []
    content {
      retention_days = var.short_term_retention_policy.retention_days
    }
  }
}