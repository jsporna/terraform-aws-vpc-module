resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc["cidr_block"]
  enable_dns_hostnames = lookup(var.vpc, "enable_dns_hostnames", "true")
  enable_dns_support   = lookup(var.vpc, "enable_dns_support", "true")

  tags = merge(
    var.tags,
    { Name = format("VPC-%s", var.vpc["name"]) }
  )
}
