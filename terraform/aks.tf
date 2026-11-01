resource "azurerm_kubernetes_cluster" "observability" {
  name                = "aks-observability-poc"
  location            = azurerm_resource_group.observability.location
  resource_group_name = azurerm_resource_group.observability.name
  dns_prefix          = "aks-observability-poc"

  sku_tier = "Free"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_D2as_v5"
    zones      = ["2"]
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id      = azurerm_log_analytics_workspace.observability.id
    msi_auth_for_monitoring_enabled = true
  }

  tags = {
    Project     = "Enterprise-Observability"
    Environment = "POC"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_monitor_diagnostic_setting" "aks" {
  name                       = "diag-aks-observability"
  target_resource_id         = azurerm_kubernetes_cluster.observability.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.observability.id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
