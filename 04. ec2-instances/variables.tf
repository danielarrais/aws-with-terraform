variable "role_ec2_access_iam_name" {
  type        = string
  description = "The name of created role to allow EC2 connect with IAM"
}

variable "ssh-key-name" {
  type = string
}

variable "sg-ec2-basic-id" {
  type = string
}

variable "ec2-ebs-vol-two-id" {
  type = string
}

variable "ec2-ebs-vol-one-id" {
  type = string
}

variable "ec2-efs-dns" {
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