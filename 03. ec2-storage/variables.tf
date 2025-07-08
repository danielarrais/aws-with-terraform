variable "sg-efs-basic-id" {
  type = string
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