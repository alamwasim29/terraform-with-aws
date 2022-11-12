locals {
  vpc_name             = join("-", slice(split("/", path.cwd), 5, 7))
  vpc_cidr_block       = "10.0.0.0/16"
  vpc_private_subnets  = [for i in range(1, 5, 2) : cidrsubnet(local.vpc_cidr_block, 8, i)]
  vpc_public_subnets   = [for i in range(2, 5, 2) : cidrsubnet(local.vpc_cidr_block, 8, i)]
  vpc_database_subnets = [for i in range(0, 5, 3) : cidrsubnet(local.vpc_cidr_block, 8, i)]
}

locals {
  owners = var.business_division
  common_tags = {
    owners      = local.owners
    environment = join("-", slice(split("/", path.cwd), 5, 6))
  }
}
