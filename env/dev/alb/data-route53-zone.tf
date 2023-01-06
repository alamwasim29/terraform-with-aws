data "aws_route53_zone" "mydomain" {
  name = "husna.cloud"
}

output "mydomain_zoneid" {
  description = "The hosted zone id of my domain."
  value       = data.aws_route53_zone.mydomain.zone_id
}

output "mydomain_name" {
  description = "The hosted zone id of my domain."
  value       = data.aws_route53_zone.mydomain.name
}
