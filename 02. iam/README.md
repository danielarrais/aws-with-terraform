# AWS IAM - Identity and Access management

## What is IAM?

IAM is a service that helps you control access to AWS resources. You use IAM to control who
is authenticated (signed in) and authorized (has permissions) to use resources.
With the IAM we have total control over of access to AWS resources.

## Users

IAM Users are entititys used to interact with AWS. The entitys can be a person, a service or an application.

### Root user

The root user is the main user of the account, the propietary of amazon account. Its diferent of the IAM user, because
the IAM user is created by the root user.

## Groups

IAM group is a coolection of IAM Users. Groups are the best way of control the permissiuons of users,
because its is easier to revoke ou assign policies of the users. A user can be in many groups.

## Roles

IAM Roles are used to assign permissions to resources, as lambda, EFS, EC2, etc, becauses as the users, the resource
needs permissions to access others resources.

## Policies

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


