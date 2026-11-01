
resource "azurerm_monitor_workspace" "prometheus" {
  name                = "amw-observability-poc"
  resource_group_name = azurerm_resource_group.observability.name
  location            = azurerm_resource_group.observability.location

  tags = {
    Project     = "Enterprise-Observability"
    Environment = "POC"
    ManagedBy   = "Terraform"
  }
}
