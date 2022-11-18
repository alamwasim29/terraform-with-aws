locals {
  vpc_name             = join("-", slice(split("/", path.cwd), 6, 8))
  vpc_cidr_block       = "10.0.0.0/16"
  vpc_private_subnets  = [for i in range(10, 12) : cidrsubnet(local.vpc_cidr_block, 8, i)]
  vpc_public_subnets   = [for i in range(100, 102) : cidrsubnet(local.vpc_cidr_block, 8, i)]
  vpc_database_subnets = [for i in range(200, 202) : cidrsubnet(local.vpc_cidr_block, 8, i)]
}

locals {
  owners = var.business_division
  common_tags = {
    owners      = local.owners
    environment = join("-", slice(split("/", path.cwd), 6, 7))
  }
}

locals {
  security_groups = {
    bastion_sg = {
      name                = "bastion-sg"
      description         = "security group for ssh open for the entire internet."
      ingress_rules       = ["ssh-tcp"]
      ingress_cidr_blocks = ["0.0.0.0/0"]
      egress_rules        = ["all-all"]
      tags                = local.common_tags
    }
    private_sg = {
      name                = "bastion-sg"
      description         = "security group for Http and ssh port open for the entire vpc cidr."
      ingress_rules       = ["ssh-tcp", "http-80-tcp"]
      ingress_cidr_blocks = [local.vpc_cidr_block]
      egress_rules        = ["all-all"]
      tags                = local.common_tags
    }
  }
}
