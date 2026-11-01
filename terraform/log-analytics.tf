
resource "azurerm_log_analytics_workspace" "observability" {
  name                = "law-observability-poc"
  resource_group_name = azurerm_resource_group.observability.name
  location            = azurerm_resource_group.observability.location

  sku               = "PerGB2018"
  retention_in_days = 30

  tags = {
    Project     = "Enterprise-Observability"
    Environment = "POC"
    ManagedBy   = "Terraform"
  }
}
