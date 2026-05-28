# Example: Buildkite Elastic CI Stack with HashiCorp Vault Integration
#
# This example demonstrates how to configure the stack to retrieve the 
# Buildkite agent token from HashiCorp Vault using the GCP Auth Method.

module "buildkite_stack" {
  source = "../../"

  project_id                  = var.project_id
  region                      = var.region
  stack_name                  = var.stack_name
  buildkite_organization_slug = var.buildkite_organization_slug

  # Vault Configuration
  # Instead of providing buildkite_agent_token or buildkite_agent_token_secret,
  # we provide the Vault connection details.
  vault_address     = var.vault_address
  vault_secret_path = var.vault_secret_path
  vault_gcp_role    = var.vault_gcp_role
  vault_namespace   = var.vault_namespace # Optional

  # Instance Configuration
  machine_type = "e2-standard-4"
  min_size     = 1
  max_size     = 5

  # The image used must have the vault CLI installed (built with the updated Packer template)
  image = var.image

  labels = {
    environment = "dev"
    managed_by  = "terraform"
    secret_mgmt = "vault"
  }
}
