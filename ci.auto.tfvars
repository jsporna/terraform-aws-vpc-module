vpc = {
  name       = "main"
  region     = "eu-central-1"
  az_count   = 3
  cidr_block = "10.10.0.0/16"
}

networks = {
  public = {
    new_bits = 7
    routing  = "public"
  },
  rds = {
    new_bits = 9
    routing  = "nat"
  }
}

tags = {
  managed_by = "terraform"
}
