output "role_ec2_access_iam_name" {
  value = aws_iam_role.tf-role-to-ec2-access-iam.name
  description = "The name of created role to allow EC2 connect with IAM"
}