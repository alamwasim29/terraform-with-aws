module "security" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.18.0"
  for_each    = local.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = each.value.ingress_rules
  ingress_cidr_blocks = each.value.ingress_cidr_blocks
  # Egress Rule - all-all open
  egress_rules = each.value.egress_rules
  tags         = local.common_tags
}
