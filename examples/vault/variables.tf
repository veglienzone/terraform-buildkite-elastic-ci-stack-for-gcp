variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
  default     = "buildkite-vault"
}

variable "buildkite_organization_slug" {
  description = "Buildkite organization slug"
  type        = string
}

variable "vault_address" {
  description = "The URL of the HashiCorp Vault server"
  type        = string
}

variable "vault_secret_path" {
  description = "The path in Vault containing the Buildkite agent token"
  type        = string
}

variable "vault_gcp_role" {
  description = "The Vault role configured for GCP authentication"
  type        = string
}

variable "vault_namespace" {
  description = "Optional Vault namespace"
  type        = string
  default     = ""
}

variable "image" {
  description = "Source image for boot disk (must have vault CLI installed)"
  type        = string
}
