variable "ec2_ids" {
  type = list(string)
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