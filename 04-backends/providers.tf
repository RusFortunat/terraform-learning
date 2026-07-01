terraform {
  required_version = "~> 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "my-terraform-state-bucket-208211371539-eu-central-1-an"
    key    = "04-backends/terraform.tfstate"
    region = "eu-central-1"
  }
}

# where infrastructure is deployed
provider "aws" {
  region = "eu-central-1"
}