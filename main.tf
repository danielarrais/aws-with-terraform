# Import IAM Module
module "iam" {
  source = "./01. iam"
}

module "ec2-security" {
  source = "./02. ec2-security"
}

# Import EC2 Module
module "ec2" {
  source = "./03. ec2"
  role_ec2_access_iam_name =  module.iam.role_ec2_access_iam_name
  sg-ssh-and-http-name = module.ec2-security.sg-ssh-and-http-name
  ssh-key-name = module.ec2-security.ssh-key-name
}

# # Import EC2 Module
# module "ec2-storage" {
#   source = "04. ec2 storage"
# }

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
