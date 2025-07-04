## IAM - Identity and Access management

IAM is a service that helps you control access to AWS resources. You use IAM to control who
is authenticated (signed in) and authorized (has permissions) to use resources.
With the IAM we have total control over access to AWS resources.

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)]

### Users

IAM Users are entities used to interact with AWS. The entities can be a person, a service, or an application.

**Root user**

The root user is the main user of the account, the proprietor of the Amazon account. It is different from the IAM user, because
the IAM user is created by the root user.

**Define users using Terraform**

```terraform
locals {
  group = "tf-group"
  users = [
    {
      name  = "tf-user-01"
      group = [local.group]
    },
    {
      name  = "tf-user-02"
      group = [local.group]
    }
  ]
}

resource "aws_iam_user" "tf-users" {
  for_each = {for user in local.users : user.name => user}
  name     = each.value.name
}
```

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users.html)]

### Groups

The IAM group is a collection of IAM Users. Groups are the best way of controlling the permissions of users
because it is easier to revoke or assign policies to the users. A user can be in many groups.

![image](https://github.com/danielarrais/aws-with-terraform/assets/28496479/85190c5f-8bb1-4c9d-8ba8-80a31fca9611)

**Define groups using Terraform**

```terraform
locals {
  group = "tf-group"
}
resource "aws_iam_group" "tf-group" {
  name = local.group
}
```

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html)]

### Roles

IAM Roles are similar to IAM users but don't have passwords, and they can be used to access the AWS console. Is util for
sharing access to services or resources between accounts, to access them as if they were you. You can create roles
mainly for services and users.

**Define roles using Terraform**

```terraform
resource "aws_iam_role" "tf-role" {
  name               = "tf-role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
```

[[Amazon Reference](https://docs.aws.amazon.com/en_us/IAM/latest/UserGuide/id_roles.html)]

### Policies

A policy is a JSON document that defines one or more permissions to access the AWS services, that can be assigned to
users, groups, or roles. The JSON has two attributes: version and statement. The version is the version of the policies of
AWS IAM, the current is
2012-10-17. The statement describes the policies, and so is the main attribute. It has the Sid, Effect, Action, Resource and
Condition:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Action": [
        "s3:CreateBucket",
        "s3:DeleteBucket"
      ],
      "Resource": [
        "*"
      ],
      "Condition": {
        "ForAnyValue:StringEquals": {
          "aws:username": [
            "aws-certification"
          ]
        }
      }
    }
  ]
}
```

- Sid: The ID of the statement, is optional.
- Effect: The effect of the statement, Allow or Deny.
- Action: The action that the statement allows or denies.
- Resource: The resource that the statement allows or denies.
- Condition: The condition that the statement allows or denies.

The AWS has a principle about the policies: Grant least privilege access, meaning you shouldn't give more
permissions a user needs.

**Define policies using Terraform**

```terraform
resource "aws_iam_policy" "tf-policy" {
  name        = "tf-policy"
  description = "Policy created using terraform"
  policy      = jsonencode({
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
```

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)]

### Password policy

The password policy is roles for the user's password:

* Password minimum length
* Password strength:
  * Requires at least one uppercase letter
  * Require at least one lowercase letter
  * Require at least one number
  * Require at least one nonalphanumeric character ! @ # $ % ^ & * ( ) _ + - = [ ] { } | '
* Turn on password expiration (minimum 1 and a maximum 1095 days)
* Password expiration requires administrator reset: when the option is activated, to renew the password the user requires
  an action of the administrator
* Allow users to change their password: you can permit all IAM users in your account to change their password.
* Prevent password reuse

**Define password policies using Terraform**

```terraform
resource "aws_iam_account_password_policy" "password-policy" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
  allow_users_to_change_password = true
}
```

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_account-policy.html)]

### IAM good practices

* Don't use the root user, except for the initial setup.
* One physycal user = one IAM user.
* Assign users to groups and assign permissions to groups.
* Create a strong password policy.
* Use and enforce the use of MFA.
* Create and use roles for giving permissions to AWS services.
* Use Access keys for programmatic access (CLI/SDK).
* Audit permissions of groups using IAM Credential reports and IAM Access Advisor.

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)]
