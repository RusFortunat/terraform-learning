terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

# Actively managed by us
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
  }
}

# Managed somewhere else, we just want to reference it
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

variable "bucket_name" {
  type        = string
  description = "My variable that is used to set a bucket name"
  default     = "my-terraform-bucket"
}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

locals {
  local_example = "This is a local variable"
}

module "my_module" {
  source = "./modules/my_module"
}