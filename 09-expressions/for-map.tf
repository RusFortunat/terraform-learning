locals {
  double_map = { for k, v in var.numbers_map : k => v * 2 }
  even_map   = { for k, v in var.numbers_map : k => v if v % 2 == 0 }
}

output "double_map" {
  value = local.double_map
}

output "even_map" {
  value = local.even_map
}