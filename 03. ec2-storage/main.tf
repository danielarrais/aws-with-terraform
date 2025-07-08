resource "aws_ebs_volume" "tf-ec2-ebs-vol-one" {
  availability_zone = "us-east-1a"
  type              = ""
  size              = 10
}

resource "aws_ebs_volume" "tf-ec2-ebs-vol-two" {
  availability_zone = "us-east-1b"
  size              = 10
}

resource "aws_efs_file_system" "tf-ec2-multi-az-efs" {
  performance_mode = "generalPurpose"
  throughput_mode = "elastic"

  lifecycle_policy {
    transition_to_ia                    = "AFTER_60_DAYS"
  }

  lifecycle_policy {
    transition_to_archive               = "AFTER_90_DAYS"
  }

  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
}

resource "aws_efs_mount_target" "tf-ec2-efs-multi-mount-1a" {
  file_system_id = aws_efs_file_system.tf-ec2-multi-az-efs.id
  subnet_id      = var.vpc.subnets.subnet_1a.id
  security_groups = [var.sg-efs-basic-id]
}

resource "aws_efs_mount_target" "tf-ec2-efs-multi-mount-1b" {
  file_system_id = aws_efs_file_system.tf-ec2-multi-az-efs.id
  subnet_id      = var.vpc.subnets.subnet_1b.id
  security_groups = [var.sg-efs-basic-id]
}

resource "aws_efs_mount_target" "tf-ec2-efs-multi-mount-1c" {
  file_system_id = aws_efs_file_system.tf-ec2-multi-az-efs.id
  subnet_id      = var.vpc.subnets.subnet_1c.id
  security_groups = [var.sg-efs-basic-id]
}