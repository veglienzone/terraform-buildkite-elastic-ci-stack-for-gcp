# Elastic CI Stack for GCP

[![Build status](https://badge.buildkite.com/3215529db5b0c43976ce30bd625724ae0f71af146ef8ac0007.svg)](https://buildkite.com/buildkite/elastic-ci-stack-for-gcp?branch=main)

Terraform modules for running autoscaling [Buildkite](https://buildkite.com/) agents on Google Cloud Platform.

## Documentation

Full documentation is available at <https://buildkite.com/docs/agent/v3/gcp/elastic-ci-stack/elastic-ci-stack>.

## Getting Started

The module ships with a set of default values which can be overridden as needed, but should be sufficient for most use cases.

```hcl
module "elastic-ci-stack-for-gcp" {
  source  = "buildkite/elastic-ci-stack-for-gcp/buildkite"
  version = "~> 0.4.0"

  # Required
  project_id                  = "your-gcp-project"
  buildkite_organization_slug = "your-org-slug"
  buildkite_agent_token       = "YOUR_AGENT_TOKEN"
}
```

## Secret Management

The stack supports three ways to manage your Buildkite agent token:

1. **Plain Text (Not recommended for production):** Provide the token directly via the `buildkite_agent_token` variable.
2. **GCP Secret Manager (Recommended):** Provide the full resource name of a secret in GCP Secret Manager via `buildkite_agent_token_secret`.
3. **HashiCorp Vault:** Fetch the token from HashiCorp Vault using the GCP Auth Method. This requires building an image with the Vault CLI installed (included in the updated Packer template).

### Vault Configuration Example

```hcl
module "elastic-ci-stack-for-gcp" {
  source = "buildkite/elastic-ci-stack-for-gcp/buildkite"

  project_id                  = "your-gcp-project"
  buildkite_organization_slug = "your-org-slug"

  # Vault Configuration
  vault_address     = "https://vault.example.com"
  vault_secret_path = "secret/data/buildkite/agent_token"
  vault_gcp_role    = "buildkite-agent-role"
}
```

## Contributing

See [Contributing Guidelines](CONTRIBUTING.md).

## License

MIT
