# Create a instance profile
# Read about here: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html
resource "aws_iam_instance_profile" "tf_created_instance_profile" {
  name = "tf-instance-profile"
  role = var.role_ec2_access_iam_name
}

# Create EC2 instance
resource "aws_instance" "tf-ec2" {
  ami           = "ami-01bc990364452ab3e"
  instance_type = "t2.micro"
  key_name      = var.ssh-key-name
  security_groups = [
    var.sg-ssh-and-http-name
  ]
  user_data = file("./03. ec2/user-data.sh")
  iam_instance_profile = aws_iam_instance_profile.tf_created_instance_profile.name

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "tf-created"
  }
}