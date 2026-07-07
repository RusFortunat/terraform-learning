locals {
  users_map = { for user in var.users : user.username => user.role... }

  users_map2 = {
    for username, roles in local.users_map : username => {
      roles = roles
    }
  }
}

output "users_map" {
  value = local.users_map
}

output "users_map2" {
  value = local.users_map2
}

output "user1_roles" {
  value = local.users_map["user1"]
}