# Example usage of the stack with an existing VPC and subnets

terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0, < 8.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Create a "pre-existing" VPC and Subnets for the sake of the example
resource "google_compute_network" "existing_vpc" {
  name                    = "existing-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "existing_subnet_a" {
  name          = "existing-subnet-a"
  ip_cidr_range = "10.10.1.0/24"
  region        = var.region
  network       = google_compute_network.existing_vpc.id
}

resource "google_compute_subnetwork" "existing_subnet_b" {
  name          = "existing-subnet-b"
  ip_cidr_range = "10.10.2.0/24"
  region        = var.region
  network       = google_compute_network.existing_vpc.id
}

# 2. Deploy the Elastic CI Stack using the existing network
module "buildkite_stack" {
  source = "../../"

  project_id = var.project_id
  region     = var.region
  stack_name = "existing-net-stack"

  # Use the existing network and subnets
  network_id        = google_compute_network.existing_vpc.id
  subnet_self_links = [
    google_compute_subnetwork.existing_subnet_a.self_link,
    google_compute_subnetwork.existing_subnet_b.self_link
  ]

  # Optional: Let the module create firewall rules on the existing network
  create_firewall_rules = true
  
  # Optional: If the existing network already has NAT, set this to false
  create_nat = true

  # Buildkite configuration
  buildkite_organization_slug = var.buildkite_organization_slug
  buildkite_agent_token       = var.buildkite_agent_token
  
  # Instance configuration
  image = var.image
}
