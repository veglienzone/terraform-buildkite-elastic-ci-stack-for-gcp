output "network_name" {
  description = "Name of the VPC network"
  value       = local.network_name
}

output "network_id" {
  description = "ID of the VPC network"
  value       = local.network_id
}

output "network_self_link" {
  description = "Self link of the VPC network"
  value       = local.network_id # In GCP, id is often the self_link or contains it
}

output "subnet_0_name" {
  description = "Name of the first subnet"
  value       = length(var.subnet_self_links) > 0 ? split("/", var.subnet_self_links[0])[length(split("/", var.subnet_self_links[0])) - 1] : google_compute_subnetwork.subnet_0[0].name
}

output "subnet_0_id" {
  description = "ID of the first subnet"
  value       = length(var.subnet_self_links) > 0 ? var.subnet_self_links[0] : google_compute_subnetwork.subnet_0[0].id
}

output "subnet_0_self_link" {
  description = "Self link of the first subnet"
  value       = length(var.subnet_self_links) > 0 ? var.subnet_self_links[0] : google_compute_subnetwork.subnet_0[0].self_link
}

output "subnet_0_cidr" {
  description = "CIDR range of the first subnet"
  value       = local.subnet_cidrs[0]
}

output "subnet_1_name" {
  description = "Name of the second subnet"
  value       = length(var.subnet_self_links) > 0 ? split("/", var.subnet_self_links[1])[length(split("/", var.subnet_self_links[1])) - 1] : google_compute_subnetwork.subnet_1[0].name
}

output "subnet_1_id" {
  description = "ID of the second subnet"
  value       = length(var.subnet_self_links) > 0 ? var.subnet_self_links[1] : google_compute_subnetwork.subnet_1[0].id
}

output "subnet_1_self_link" {
  description = "Self link of the second subnet"
  value       = length(var.subnet_self_links) > 0 ? var.subnet_self_links[1] : google_compute_subnetwork.subnet_1[0].self_link
}

output "subnet_1_cidr" {
  description = "CIDR range of the second subnet"
  value       = local.subnet_cidrs[1]
}

output "router_name" {
  description = "Name of the Cloud Router (if created)"
  value       = var.create_nat ? google_compute_router.router[0].name : null
}

output "nat_name" {
  description = "Name of the Cloud NAT (if created)"
  value       = var.create_nat ? google_compute_router_nat.nat[0].name : null
}

output "ssh_firewall_rule_name" {
  description = "Name of the SSH firewall rule (if enabled)"
  value       = var.create_firewall_rules && var.enable_ssh_access ? google_compute_firewall.ssh_ingress[0].name : null
}

output "internal_firewall_rule_name" {
  description = "Name of the internal communication firewall rule (if enabled)"
  value       = var.create_firewall_rules ? google_compute_firewall.internal[0].name : null
}

output "health_checks_firewall_rule_name" {
  description = "Name of the health checks firewall rule (if enabled)"
  value       = var.create_firewall_rules ? google_compute_firewall.health_checks[0].name : null
}

output "iap_firewall_rule_name" {
  description = "Name of the IAP firewall rule (if enabled)"
  value       = var.create_firewall_rules && var.enable_iap_access ? google_compute_firewall.iap[0].name : null
}

output "subnets" {
  description = "List of subnet objects for use with instance groups"
  value = [
    {
      name      = length(var.subnet_self_links) > 0 ? split("/", var.subnet_self_links[0])[length(split("/", var.subnet_self_links[0])) - 1] : google_compute_subnetwork.subnet_0[0].name
      self_link = length(var.subnet_self_links) > 0 ? var.subnet_self_links[0] : google_compute_subnetwork.subnet_0[0].self_link
      region    = length(var.subnet_self_links) > 0 ? data.google_compute_subnetwork.existing_subnets[0].region : google_compute_subnetwork.subnet_0[0].region
      cidr      = local.subnet_cidrs[0]
    },
    {
      name      = length(var.subnet_self_links) > 0 ? split("/", var.subnet_self_links[1])[length(split("/", var.subnet_self_links[1])) - 1] : google_compute_subnetwork.subnet_1[0].name
      self_link = length(var.subnet_self_links) > 0 ? var.subnet_self_links[1] : google_compute_subnetwork.subnet_1[0].self_link
      region    = length(var.subnet_self_links) > 0 ? data.google_compute_subnetwork.existing_subnets[1].region : google_compute_subnetwork.subnet_1[0].region
      cidr      = local.subnet_cidrs[1]
    }
  ]
}

output "instance_tag" {
  description = "Network tag to apply to compute instances for firewall targeting"
  value       = var.instance_tag
}
