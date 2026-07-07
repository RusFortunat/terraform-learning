locals {
  name = "Ruslan Mukhamadiarov"
  age  = 33
  my_object = {
    key1 = "value1"
    key2 = "value2"
  }
}

output "example1" {
  value = upper(local.name)
}

output "example2" {
  value = startswith(local.name, "Ruslan")
}

output "example3" {
  value = pow(local.age, 2)
}

output "example4" {
  value = yamldecode(file("${path.module}/users.yaml")).users
}

output "example5" {
  value = yamlencode(local.my_object)
}

output "example6" {
  value = jsonencode(local.my_object)
}