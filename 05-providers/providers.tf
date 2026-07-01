terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.15.0"
}

provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "west"
}

resource "aws_s3_bucket" "eu_central_1" {
  bucket = "random-bucket-name-eu-central-1"

  tags = {
    Name = "eu-central-1-random-bucket"
  }
}

resource "aws_s3_bucket" "eu_west_1" {
  bucket   = "random-bucket-name-eu-west-1"
  provider = aws.west

  tags = {
    Name = "eu-west-1-random-bucket"
  }
}