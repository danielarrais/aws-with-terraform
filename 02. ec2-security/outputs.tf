output "ssh-key-name" {
  value = aws_key_pair.tf-ssh-key.key_name
}

output "sg-ssh-and-http-name" {
  value = aws_security_group.tf-sg-ssh-and-http.name
}