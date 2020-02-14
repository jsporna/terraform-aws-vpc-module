locals {
  azs = ["a", "b", "c", "d", "e", "f"]

  avability_zones = toset([for az in slice(local.azs, 0, var.vpc["az_count"]) : format("%s%s", var.vpc["region"], az)])

  cidr_block_netmask = split("/", var.vpc["cidr_block"])[1]

  default_networks = {
    public = {
      new_bits = 24 - local.cidr_block_netmask
      routnig  = "public"
    },
    nat = {
      new_bits = 24 - local.cidr_block_netmask
      routing  = "nat"
    }
  }

  input_networks = merge(local.default_networks, var.networks)

  networks = flatten([
    for az in local.avability_zones : [
      for name, attr in local.input_networks : {
        name     = format("%s_%s", name, az),
        new_bits = attr.new_bits,
        routing  = attr.routing
      }
    ]
  ])

}
