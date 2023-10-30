## AWS IAM - Identity and Access management

IAM is a service that helps you control access to AWS resources. You use IAM to control who
is authenticated (signed in) and authorized (has permissions) to use resources.
With the IAM we have total control over of access to AWS resources.

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)]

### Users

IAM Users are entititys used to interact with AWS. The entitys can be a person, a service or an application.

**Root user**

The root user is the main user of the account, the propietary of amazon account. Its diferent of the IAM user, because
the IAM user is created by the root user.

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users.html)]

### Groups

IAM group is a coolection of IAM Users. Groups are the best way of control the permissiuons of users,
because its is easier to revoke ou assign policies of the users. A user can be in many groups.

![image](https://github.com/danielarrais/aws-with-terraform/assets/28496479/85190c5f-8bb1-4c9d-8ba8-80a31fca9611)

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html)]

### Roles

IAM Roles are simmilar to IAM users, but no have password and no can be used to login in AWS console. Is util for
sharing access to services or resources between accounts, to access them as if they were you. You can create roles
mainly for services and users.

[[Amazon Reference](https://docs.aws.amazon.com/en_us/IAM/latest/UserGuide/id_roles.html)]

### Policies

A policie is a JSON document that defines one or more permissions to access the AWS services, that can be assigned to
users, groups or roles. The JSON has two attributes: version and statement. The version is ther version of policies of
AWS IAM, the current is
2012-10-17. The statement describe the policie, so is the main attribute. Its has the Sid, Effect, Action, Resource and
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

- Sid: The ID of the statement, its optional.
- Effect: The effect of the statement, Allow or Deny.
- Action: The action that the statement allows or denies.
- Resource: The resource that the statement allows or denies.
- Condition: The condition that the statement allows or denny.

The AWS has a principle about the policies: Grant least privilege access, meaning you shouldn't give more
permissions a user needs.

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)]

### Password policy

The password policy are roles for users password:

* Password minimum length
* Password strength:
    * Requires at lest one uppercase letter
    * Require at least one lowercase letter
    * Require at least one number
    * Require at least one nonalphanumeric character ! @ # $ % ^ & * ( ) _ + - = [ ] { } | '
* Turn on password expiration (minimum 1 and a maximum 1095 days)
* Password expiration requires administrator reset: when the option is actived, for renew the password the user requires
  an action of the adminitrator
* Allow users to change their own password: you can permit all IAM users in your account to change their own password.
* Prevent password reuse

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_account-policy.html)]

### IAM good practices

* Don't use the root user, except for the initial setup.
* One physycal user = one IAM user.
* Assign users to groups and assign permissions to groups.
* Create a strong password policy.
* Use and enforce the use of MFA.
* Create and use roles for giving permissions to AWS services.
* Use Access keys for programmatic access (CLI/SDK).
* Audit permissions of groups using IAM Credential reports and IAM Access Adivisor.

[[Amazon Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)]