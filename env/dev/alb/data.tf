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
