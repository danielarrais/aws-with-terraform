# Import IAM Module
module "iam" {
  source = "./01. iam"
}

module "ec2-security" {
  source = "./02. ec2-security"
}

module "ec2-storage" {
  source = "./03. ec2-storage"
}

# Import EC2 Module
module "ec2" {
  source = "./04. ec2-instances"

  # ec2 security
  role_ec2_access_iam_name =  module.iam.role_ec2_access_iam_name
  sg-ssh-and-http-name = module.ec2-security.sg-ssh-and-http-name
  ssh-key-name = module.ec2-security.ssh-key-name

  # ebs volumes arn's
  ec2-ebs-vol-one = module.ec2-storage.ec2-ebs-vol-one
  ec2-ebs-vol-two = module.ec2-storage.ec2-ebs-vol-two
}

terraform {
  required_version = "~> 1.12.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
