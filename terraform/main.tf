
resource "azurerm_resource_group" "observability" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Project     = "Enterprise-Observability"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
