resource "aws_ebs_volume" "tf-ec2-ebs-vol-one" {
  availability_zone = "us-east-1a"
  size = 10
}

resource "aws_ebs_volume" "tf-ec2-ebs-vol-two" {
  availability_zone = "us-east-1a"
  size = 10
}