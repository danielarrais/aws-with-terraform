output "ec2-ebs-vol-one-id" {
  value = aws_ebs_volume.tf-ec2-ebs-vol-one.id
}

output "ec2-ebs-vol-two-id" {
  value = aws_ebs_volume.tf-ec2-ebs-vol-two.id
}

output "ec2-efs-multi-az-id" {
  value = aws_efs_file_system.tf-ec2-multi-az-efs.id
}

output "ec2-efs-multi-az-dns" {
  value = aws_efs_file_system.tf-ec2-multi-az-efs.dns_name
}