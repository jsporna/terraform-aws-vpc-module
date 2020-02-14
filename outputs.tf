output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The id of created AWS VPC"
}

output "inet_gw_id" {
  value       = aws_internet_gateway.internet.id
  description = "The id of internet gw for created AWS VPC"
}

output "nat_gws" {
  value = { for i, nat in aws_nat_gateway.nat_gw : i => {
    id         = nat.id
    private_ip = nat.private_ip
    public_ip  = nat.public_ip
  } }
  description = "The ids of nat gw for created AWS VPC"
}

output "azs" {
  value       = local.avability_zones
  description = "List AWS Region AZs"
}

output "subnet_cidrs" {
  value       = module.subnets.network_cidr_blocks
  description = "Map of computed subnet CIDRs"
}

output "subnet_ids" {
  value       = { for k, v in module.subnets.network_cidr_blocks : k => aws_subnet.subnets[k].id }
  description = "Map of created subnet ids"
}

output "subnet_cidrs_by_az" {
  value = {
    for az in local.avability_zones : az => {
      for sk, sv in module.subnets.network_cidr_blocks : trimsuffix(sk, format("_%s", az)) => sv if split("_", sk)[1] == az
    }
  }
  description = "Map of subnets' CIDR by AZs"
}

output "subnet_cidrs_by_name" {
  value = {
    for k, _ in local.input_networks : k => {
      for az in local.avability_zones : az => module.subnets.network_cidr_blocks[format("%s_%s", k, az)]
    }
  }
  description = "Map of subnets' CIDR by names"
}

output "subnet_cidrs_list_by_name" {
  value = {
    for k, _ in local.input_networks : k => [
      for az in local.avability_zones : module.subnets.network_cidr_blocks[format("%s_%s", k, az)]
    ]
  }
  description = "List of subnets' CIDR by names"
}

output "subnet_ids_by_az" {
  value = {
    for az in local.avability_zones : az => {
      for sk, sv in module.subnets.network_cidr_blocks : trimsuffix(sk, format("_%s", az)) => aws_subnet.subnets[sk].id if split("_", sk)[1] == az
    }
  }
  description = "Map of subnets' ids by AZs"
}

output "subnet_ids_by_name" {
  value = {
    for k, _ in local.input_networks : k => {
      for az in local.avability_zones : az => aws_subnet.subnets[format("%s_%s", k, az)].id
    }
  }
  description = "Map of subnets' ids by names"
}

output "subnet_ids_list_by_name" {
  value = {
    for k, _ in local.input_networks : k => [
      for az in local.avability_zones : aws_subnet.subnets[format("%s_%s", k, az)].id
    ]
  }
  description = "List of subnets' ids by names"
}

