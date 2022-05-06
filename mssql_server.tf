# Creating mssql server
resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  minimum_tls_version          = var.minimum_tls_version
  tags                         = var.tag_map

  connection_policy                    = var.connection_policy
  public_network_access_enabled        = var.public_network_access_enabled
  outbound_network_restriction_enabled = var.outbound_network_restriction_enabled
  # primary_user_assigned_identity_id    = var.primary_user_assigned_identity_id

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }
  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator != null ? [var.azuread_administrator] : []
    content {
      login_username = var.azuread_administrator.login_username
      object_id      = var.azuread_administrator.object_id
      tenant_id      = var.tenant_id
      azuread_authentication_only = var.azuread_authentication_only
    }
  }
}

/*-------------------- Private endpint ------------------- */
data "azurerm_virtual_network" "existing-virtual-network" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing-subnet" {
  count                = var.enable_private_endpoint ? 1 : 0
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
}

resource "azurerm_private_endpoint" "mssql_private_endpoint" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = format("%s-primary", "mssqldb-private-endpoint")
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.existing-subnet[0].id

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = azurerm_mssql_server.mssql_server.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }
}

data "azurerm_private_endpoint_connection" "mssql_private_endpoint_connection" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = azurerm_private_endpoint.mssql_private_endpoint.0.name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_mssql_server.mssql_server]
}

resource "azurerm_private_dns_zone" "mssql_private_dns_zone" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tag_map
}

resource "azurerm_private_dns_zone_virtual_network_link" "mssql_private_dns_zone_virtual_network_link" {
  count                 = var.enable_private_endpoint ? 1 : 0
  name                  = var.private_dns_zone_virtual_network_link_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.mssql_private_dns_zone.0.name
  virtual_network_id    = data.azurerm_virtual_network.existing-virtual-network[0].id
  registration_enabled  = false
  tags                  = var.tag_map
}

resource "azurerm_private_dns_a_record" "mssql_private_dns_a_record" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = azurerm_mssql_server.mssql_server.name
  zone_name           = azurerm_private_dns_zone.mssql_private_dns_zone.0.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.mssql_private_endpoint_connection.0.private_service_connection.0.private_ip_address]
}

