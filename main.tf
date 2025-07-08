# Import IAM Module
module "iam" {
  source = "./01. iam"
}

module "ec2-vpc" {
  source = "./05. vpc"
}

module "ec2-security" {
  source = "./02. ec2-security"
  vpc = module.ec2-vpc.main_vpc
}

module "ec2-storage" {
  source = "./03. ec2-storage"
  vpc = module.ec2-vpc.main_vpc
  sg-efs-basic-id = module.ec2-security.sg-efs-basic-id
}

# Import EC2 Module
module "ec2" {
  source = "./04. ec2-instances"
  vpc = module.ec2-vpc.main_vpc

  # ec2 security
  role_ec2_access_iam_name =  module.iam.role_ec2_access_iam_name
  sg-ec2-basic-id = module.ec2-security.sg-ec2-basic-id
  ssh-key-name = module.ec2-security.ssh-key-name

  # ebs volumes arn's
  ec2-ebs-vol-one-id = module.ec2-storage.ec2-ebs-vol-one-id
  ec2-ebs-vol-two-id = module.ec2-storage.ec2-ebs-vol-two-id

  # efs ids
  ec2-efs-dns       = module.ec2-storage.ec2-efs-multi-az-dns
}

terraform {
  required_version = "~> 1.12.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
