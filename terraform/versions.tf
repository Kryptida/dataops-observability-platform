terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # The bucket name is passed at init time (see README), so it is not hardcoded here.
  backend "s3" {
    key          = "dataops/terraform.tfstate"
    region       = "us-east-1"
    profile      = "dataops"
    encrypt      = true
    use_lockfile = true
  }
}
