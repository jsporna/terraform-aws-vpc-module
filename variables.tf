variable "networks" {
  description = "Map of networks with new bits and type of routing"
  type = map(object({
    new_bits = number
    routing  = string
  }))
}

variable "vpc" {
  description = "Attributes of AWS VPC"
  type = object({
    name       = string
    region     = string
    az_count   = number
    cidr_block = string
  })
}

variable "tags" {
  description = "Common tags for all resources created by terraform module"
  type        = map(string)
}
