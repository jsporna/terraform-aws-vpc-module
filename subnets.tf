module "subnets" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.vpc["cidr_block"]
  networks        = local.networks
}

resource "aws_subnet" "subnets" {
  depends_on = [module.subnets]
  for_each   = module.subnets.network_cidr_blocks

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = split("_", each.key)[1]

  tags = merge(
    var.tags,
    { Name = format("SN-%s-%s", each.key, var.vpc["name"]) },
    { AZ = split("_", each.key)[1] },
    { Group = split("_", each.key)[0] },
    { VPC = var.vpc["name"] }
  )
}
