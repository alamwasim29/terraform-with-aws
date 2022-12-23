locals {
  owners = var.business_division
  common_tags = {
    owners      = local.owners
    environment = basename(dirname(path.cwd))
  }
}
