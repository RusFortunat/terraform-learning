locals {
  project       = "08-input-variables"
  project_owner = "me, Mario"
  cost_center   = "Terraform Learning"
  managed_by    = "Terraform"
}

locals {
  common_tags = {
    ProjectOwner = local.project_owner
    CostCenter   = local.cost_center
    ManagedBy    = local.managed_by
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "compute" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.public.id

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_config.size
    volume_type           = var.ec2_volume_config.type
  }

  tags = merge(local.common_tags, var.additional_tags)
}

