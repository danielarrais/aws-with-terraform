# Create a instance profile
# Read about here: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html
resource "aws_iam_instance_profile" "tf_created_instance_profile" {
  name = "tf-instance-profile"
  role = var.role_ec2_access_iam_name
}

# Create EC2 instance
resource "aws_instance" "tf-ec2-1" {
  ami           = "ami-01bc990364452ab3e"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  subnet_id = var.vpc.subnets.subnet_1a.id
  key_name      = var.ssh-key-name
  vpc_security_group_ids = [
    var.sg-ec2-basic-id
  ]
  iam_instance_profile = aws_iam_instance_profile.tf_created_instance_profile.name

  associate_public_ip_address = true

  # Format the EBS vol and start a nginx server
  user_data = templatefile("${path.module}/user-data.sh", {
    efs_dns = var.ec2-efs-dns
  })

  # Create a ebs vol
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "tf-created"
  }
}

# Create EC2 instance
resource "aws_instance" "tf-ec2-2" {
  ami           = "ami-01bc990364452ab3e"
  instance_type = "t2.micro"
  availability_zone = "us-east-1b"
  subnet_id = var.vpc.subnets.subnet_1b.id
  key_name      = var.ssh-key-name
  vpc_security_group_ids = [
    var.sg-ec2-basic-id
  ]
  iam_instance_profile = aws_iam_instance_profile.tf_created_instance_profile.name

  associate_public_ip_address = true

  # Format the EBS vol and start a nginx server
  user_data = templatefile("${path.module}/user-data.sh", {
    efs_dns = var.ec2-efs-dns
  })

  # Create a ebs vol
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "tf-created"
  }
}

# Attach a EBS volume on Ec2 instance
resource "aws_volume_attachment" "tf-ec2-vol-one" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.tf-ec2-1.id
  volume_id   = var.ec2-ebs-vol-one-id

  depends_on = [aws_instance.tf-ec2-1]
}

# Attach a EBS volume on Ec2 instance
resource "aws_volume_attachment" "tf-ec2-vol-two" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.tf-ec2-2.id
  volume_id   = var.ec2-ebs-vol-two-id

  depends_on = [aws_instance.tf-ec2-2]
}