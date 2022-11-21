output "public_subnet_id" {
  description = "vpc public subnet id to be used in compute instances."
  value       = module.vpc.public_subnets
}

output "public_security_group" {
  description = "sg for instances in public group."
  value       = module.security["public_sg"].security_group_id

}
