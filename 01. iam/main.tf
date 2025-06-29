locals {
  group = "tf-created-group"
  users = [
    {
      name = "tf-created-user-01"
      group = [local.group]
    },
    {
      name = "tf-created-user-02"
      group = [local.group]
    }
  ]
}

# Create a role
resource "aws_iam_role" "tf-created-role" {
  name = "tf-created-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attach a policy to tf-created-role-to-ec2-access-iam
resource "aws_iam_role_policy_attachment" "iam_readonly" {
  role       = aws_iam_role.tf-created-role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

# Create policie
resource "aws_iam_policy" "tf-created-policy" {
  name        = "tf-created-policy"
  description = "Policy created using terraform"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:ListAllMyBuckets"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

# Create users
resource "aws_iam_user" "tf-created-users" {
  for_each = {for user in local.users : user.name => user}
  name     = each.value.name
}

# Create a new group
resource "aws_iam_group" "tf-created-group" {
  name = local.group
}

# Attach AWS managed policies to group
resource "aws_iam_group_policy_attachment" "attach-policy-to-group" {
  group      = aws_iam_group.tf-created-group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Attach tf-created policies to group
resource "aws_iam_group_policy_attachment" "attach-tf-created-policy-to-group" {
  group      = aws_iam_group.tf-created-group.name
  policy_arn = aws_iam_policy.tf-created-policy.arn
}

# Define password policies
resource "aws_iam_account_password_policy" "password-policy" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
  allow_users_to_change_password = true
}

# Apply groups to users
resource "aws_iam_user_group_membership" "add-users-to-groups" {
  for_each = {for user in local.users : user.name => user}
  groups   = each.value.group
  user     = each.value.name
  depends_on = [
    aws_iam_user.tf-created-users,
    aws_iam_group.tf-created-group
  ]
}