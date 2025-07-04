output "instance_public_ip" {
  value = aws_instance.tf-ec2.public_ip
  description = "The public IP address of the EC2 instance"
}