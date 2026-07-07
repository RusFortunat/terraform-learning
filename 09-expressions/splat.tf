locals {
  firstnames_from_splat = var.objects_list[*].name
  roles_from_splat      = values(local.users_map2)[*].roles
}

output "firstnames_from_splat" {
  value = local.firstnames_from_splat
}

output "roles_from_splat" {
  value = local.roles_from_splat
}