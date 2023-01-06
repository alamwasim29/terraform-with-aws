data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "tfstate-repo-s3"
    key     = "dec-22/env/dev/vpc/vpc.tf"
    region  = "us-east-1"
    profile = "terraform"
  }

}

data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket  = "tfstate-repo-s3"
    key     = "dec-22/env/dev/compute/compute.tf"
    region  = "us-east-1"
    profile = "terraform"
  }

}

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

