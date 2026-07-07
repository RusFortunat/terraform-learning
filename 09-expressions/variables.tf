variable "numbers_list" {
  type = list(number)
}

variable "numbers_map" {
  type = map(number)
}

variable "objects_list" {
  type = list(object({
    name = string
    age  = number
  }))
}

variable "users" {
  type = list(object({
    username = string
    role     = string
  }))

}