# Import IAM Module
module "iam" {
  source = "./01. iam"
}

# Import EC2 Module
module "ec2" {
  source = "./02. ec2"
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
