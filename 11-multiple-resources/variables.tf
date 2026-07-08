variable "subnet_config" {
  description = "Number of subnets to create"
  type        = map(object({
    cidr_block        = string
  }))
  default     = 2

  # Ensure that all cidr blocks are valid
  validation {
    condition     = alltrue([for subnet in values(var.subnet_config) : 
      can(cidrnetmask(subnet.cidr_block))])
    error_message = "At least one cidr block is not valid"
  }
}

variable "ec2_instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "ec2_instance_config_list" {
  type = list(object({
    ami           = string
    instance_type = string
    subnet_name    = optional(string, "default") # Default to "default" if not provided
  }))

  default = []

  # Ensure only t2.micro and t3.micro are used
  validation {
    condition = alltrue([
      for inst_config in var.ec2_instance_config_list : 
        contains(["t2.micro", "t3.micro"], inst_config.instance_type)])
    error_message = "Only t2.micro and t3.micro instance types are allowed."
  }

  # Ensure only ubuntu and nginx AMIs are used
  validation {
    condition = alltrue([
      for ami in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], ami.ami)
    ])
    error_message = "Only 'ubuntu' and 'nginx' AMIs are allowed."
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    ami           = string
    instance_type = string
    subnet_name  = optional(string, "default") # Default to "default" if not provided
  }))


  # Ensure only t2.micro and t3.micro are used
  validation {
    condition = alltrue([
      for inst_config in values(var.ec2_instance_config_map): 
        contains(["t2.micro", "t3.micro"], inst_config.instance_type)])
    error_message = "Only t2.micro and t3.micro instance types are allowed."
  }

  # Ensure only ubuntu and nginx AMIs are used
  validation {
    condition = alltrue([
      for ami in values(var.ec2_instance_config_map): 
        contains(["ubuntu", "nginx"], ami.ami)
    ])
    error_message = "Only 'ubuntu' and 'nginx' AMIs are allowed."
  }

  # Subnet index validation
  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map): 
        config.subnet_index >= 0 && config.subnet_index < var.subnet_count
    ])
    error_message = "Subnet index is out of bounds."
  }
}

