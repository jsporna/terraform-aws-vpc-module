resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    { Name = format("Public-Routing-%s", var.vpc["name"]) },
    { VPC = var.vpc["name"] }
  )
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet.id
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "nat" {
  for_each = local.avability_zones
  vpc_id   = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    { Name = format("NAT-Routing-%s-%s", each.key, var.vpc["name"]) },
    { AZ = each.key },
    { VPC = var.vpc["name"] }
  )
}

resource "aws_route" "nat" {
  for_each = local.avability_zones

  route_table_id         = aws_route_table.nat[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw[each.key].id
}

resource "aws_route_table_association" "public" {
  for_each = toset([for network in local.networks : network.name if network.routing == "public"])

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.subnets[each.key].id
}

resource "aws_route_table_association" "nat" {
  for_each = toset([for network in local.networks : network.name if network.routing == "nat"])

  route_table_id = aws_route_table.nat[split("_", each.key)[1]].id
  subnet_id      = aws_subnet.subnets[each.key].id
}
