## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.20 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| networks | Map of networks with new bits and type of routing | <pre>map(object({<br>    new_bits = number<br>    routing  = string<br>  }))<br></pre> | n/a | yes |
| tags | Common tags for all resources created by terraform module | `map(string)` | n/a | yes |
| vpc | Attributes of AWS VPC | <pre>object({<br>    name       = string<br>    region     = string<br>    az_count   = number<br>    cidr_block = string<br>  })<br></pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| azs | List AWS Region AZs |
| inet\_gw\_id | The id of internet gw for created AWS VPC |
| nat\_gws | The ids of nat gw for created AWS VPC |
| subnet\_cidrs | Map of computed subnet CIDRs |
| subnet\_cidrs\_by\_az | Map of subnets' CIDR by AZs |
| subnet\_cidrs\_by\_name | Map of subnets' CIDR by names |
| subnet\_cidrs\_list\_by\_name | List of subnets' CIDR by names |
| subnet\_ids | Map of created subnet ids |
| subnet\_ids\_by\_az | Map of subnets' ids by AZs |
| subnet\_ids\_by\_name | Map of subnets' ids by names |
| subnet\_ids\_list\_by\_name | List of subnets' ids by names |
| vpc\_id | The id of created AWS VPC |
