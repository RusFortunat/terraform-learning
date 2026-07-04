data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id

  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp3"
  }
}

resource "aws_s3_bucket" "public_read_bucket" {
  bucket = "my-static-website-bucket"
}

# Test data sources functionality
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.public_read_bucket.arn}/*"
    ]
  }
}

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "current_region" {
  value = data.aws_region.current.name
}

output "default_vpc_id" {
  value = data.aws_vpc.default_vpc.id
}

output "available_zones" {
  value = data.aws_availability_zones.available.names
}

output "iam_policy" {
  value = data.aws_iam_policy_document.static_website.json
}

