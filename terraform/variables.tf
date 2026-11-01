
variable "resource_group_name" {
  description = "Resource Group for Observability POC"
  type        = string
}

variable "location" {
  description = "Azure deployment region"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "POC"
}
