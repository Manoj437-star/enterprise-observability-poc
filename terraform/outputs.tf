output "resource_group_name" {
  description = "Created Resource Group name"
  value       = azurerm_resource_group.observability.name
}

output "resource_group_location" {
  description = "Resource Group location"
  value       = azurerm_resource_group.observability.location
}

output "resource_group_id" {
  description = "Resource Group resource ID"
  value       = azurerm_resource_group.observability.id
}

output "kubernetes_cluster_name" {
  description = "AKS Cluster Name"
  value       = azurerm_kubernetes_cluster.observability.name
}

output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace Resource ID"
  value       = azurerm_log_analytics_workspace.observability.id
}
