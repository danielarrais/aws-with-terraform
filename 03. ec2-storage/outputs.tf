output "ec2-ebs-vol-one" {
  value = aws_ebs_volume.tf-ec2-ebs-vol-one.arn
}

output "ec2-ebs-vol-two" {
  value = aws_ebs_volume.tf-ec2-ebs-vol-two.arn
}