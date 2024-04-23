terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}

provider "aws" {
  region                      = var.region_name
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}
