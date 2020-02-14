resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

resource "aws_eip" "nat_gw_eip" {
  for_each = local.avability_zones

  vpc = true
  tags = merge(
    var.tags,
    { Name = format("NAT-GW-EIP-%s-%s", each.key, var.vpc["name"]) }
  )
}

resource "aws_nat_gateway" "nat_gw" {
  depends_on = [
    aws_internet_gateway.internet,
    aws_eip.nat_gw_eip
  ]

  for_each = local.avability_zones

  allocation_id = aws_eip.nat_gw_eip[each.key].id
  subnet_id     = aws_subnet.subnets[format("public_%s", each.key)].id

  tags = merge(
    var.tags,
    { Name = format("NAT-GW-%s-%s", each.key, var.vpc["name"]) }
  )
}
