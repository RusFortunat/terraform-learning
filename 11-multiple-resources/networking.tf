resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${local.project_name}-vpc"
  }
}

resource "aws_subnet" "main" {
  for_each          = var.subnet_config
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block

  tags = {
    Name = "${local.project_name}-${each.key}-subnet"
  }
}