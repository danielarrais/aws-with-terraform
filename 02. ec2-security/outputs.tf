output "ssh-key-name" {
  value = aws_key_pair.tf-ssh-key.key_name
}

output "sg-ec2-basic-id" {
  value = aws_security_group.tf-sg-ec2-basic.id
}

output "sg-efs-basic-id" {
  value = aws_security_group.tf-sg-efs-basic.id
}