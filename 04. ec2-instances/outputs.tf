output "instances" {
  value = {
    ec2-1 = {
      id = aws_instance.tf-ec2-1.id
      public-ip = aws_instance.tf-ec2-1.public_ip
    }
    ec2-2 = {
      id = aws_instance.tf-ec2-2.id
      public-ip = aws_instance.tf-ec2-2.public_ip
    }
  }
  description = "The public IP address of the EC2 instance"
}