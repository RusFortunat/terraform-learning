locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id,
    nginx  = data.aws_ami.nginx.id
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

data "aws_ami" "nginx" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-nginx-*"]
  }
}

resource "aws_instance" "from_list" {
  count         = length(var.ec2_instance_config_list)
  ami           = locals.ami_ids[var.ec2_instance_config_list[count.index].ami]
  instance_type = var.ec2_instance_config_list[count.index].instance_type
  subnet_id     = aws_subnet.main[
    var.ec2_instance_config_list[count.index].subnet_name
  ].id # holy jesus christ

  tags = {
    Name = "${local.project_name}-${count.index}"
  }
}

resource "aws_instance" "from_map" {
  for_each      = var.ec2_instance_config_map
  ami           = locals.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.main[each.value.subnet_name].id

  tags = {
    Name = "${local.project_name}-${each.key}"
  }
}


