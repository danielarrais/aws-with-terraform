variable "instance_type" {
  type = string                     # The type of the variable, in this case a string
  default = "t2.micro"                 # Default value for the variable
  description = "The type of EC2 instance" # Description of what this variable represents
}

variable "vpc" {
  type = object({
    id         = string
    cidr_block = string
    subnets = object({
      subnet_1a = object({
        id         = string
        cidr_block = string
      })
      subnet_1b = object({
        id         = string
        cidr_block = string
      })
      subnet_1c = object({
        id         = string
        cidr_block = string
      })
    })
  })
}