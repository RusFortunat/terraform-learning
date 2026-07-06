data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}

variable "ec2_instance_type" {
  description = "The type of the EC2 instance"
  type        = string
  default     = "t2.micro"
  sensitive   = true

  validation {
    condition     = contains(["t3.micro", "t3.small", "t2.micro"], var.ec2_instance_type)
    error_message = "The EC2 instance type must be one of: t3.micro, t3.small, t2.micro."
  }
}

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })
  description = "The size and type of the EC2 root volume"

  default = {
    size = 8
    type = "gp3"
  }
}

variable "additional_tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}