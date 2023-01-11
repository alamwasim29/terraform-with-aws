output "pub_subnet_id" {
  description = "vpc public subnet id to be used in compute instances."
  value       = module.vpc.public_subnets
}
output "pvt_subnet_id" {
  description = "vpc private subnet id to be used in compute instances."
  value       = module.vpc.private_subnets
}

output "pub_security_group" {
  description = "sg for instances in public group."
  value       = module.security["public_sg"].security_group_id

}
output "pvt_security_group" {
  description = "sg for instances in private group."
  value       = module.security["private_sg"].security_group_id

}
output "alb_security_group" {
  description = "sg for instances in private group."
  value       = module.security["alb_sg"].security_group_id

}

output "vpc_id" {
  description = "vpc id to be used by other resources."
  value       = module.vpc.vpc_id

}
output "azs" {
  description = "azs to be used by other resources."
  value       = module.vpc.azs

}
