terraform {
  backend "s3" {
    bucket  = "tfstate-repo-s3"
    key     = "dec-22/env/dev/vpc/vpc.tf"
    region  = "us-east-1"
    profile = "terraform"

    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
