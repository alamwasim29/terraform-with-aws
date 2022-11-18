terraform {
  backend "s3" {
    bucket  = "tfstate-repo-s3"
    key     = "env/dev/compute/compute.tf"
    region  = "us-east-1"
    profile = "terraform"

    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
