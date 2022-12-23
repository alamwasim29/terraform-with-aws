output "pvt_instance_id" {
  description = "Private instance id."
  value       = module.ec2_pvt[*].id

}
