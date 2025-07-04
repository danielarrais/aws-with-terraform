variable "role_ec2_access_iam_name" {
  type        = string
  description = "The name of created role to allow EC2 connect with IAM"
}

variable "ssh-key-name" {
  type = string
}

variable "sg-ssh-and-http-name" {
  type = string
}

variable "ec2-ebs-vol-two" {
  type = string
}

variable "ec2-ebs-vol-one" {
  type = string
}