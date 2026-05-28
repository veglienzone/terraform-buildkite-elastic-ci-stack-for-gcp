variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "buildkite_organization_slug" {
  description = "Buildkite organization slug"
  type        = string
}

variable "buildkite_agent_token" {
  description = "Buildkite agent registration token"
  type        = string
  sensitive   = true
}

variable "image" {
  description = "Source image for boot disk"
  type        = string
}
