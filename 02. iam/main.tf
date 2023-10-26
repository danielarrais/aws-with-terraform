terraform {
  required_version = "~> 1.6.2"
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

locals {
  users = [
    {
      name  = "tf-created-01"
      group = [aws_iam_group.console_group.name]
    },
    {
      name  = "tf-created-02"
      group = [aws_iam_group.console_group.name]
    }
  ]
}


# Create a new group
resource "aws_iam_group" "console_group" {
  name = "console"
}

resource "aws_iam_group_policy_attachment" "console_group_policy" {
  group      = aws_iam_group.console_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Define password policies
resource "aws_iam_account_password_policy" "password_policy" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
  allow_users_to_change_password = true
}

# Create users
resource "aws_iam_user" "samples-users" {
  for_each = {for user in local.users : user.name => user}
  name     = each.value.name
}

# Apply groups to users
resource "aws_iam_user_group_membership" "samples-users-groups" {
  for_each   = {for user in local.users : user.name => user}
  groups     = each.value.group
  user       = each.value.name
  depends_on = [
    aws_iam_user.samples-users
  ]
}