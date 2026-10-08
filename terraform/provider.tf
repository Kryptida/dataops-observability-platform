provider "aws" {
  region  = var.region
  profile = "dataops"

  default_tags {
    tags = {
      Project   = var.project
      ManagedBy = "terraform"
    }
  }
}
