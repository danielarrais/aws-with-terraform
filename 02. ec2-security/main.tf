# Create SSH key pair (it's necessary to configure EC2 instances)
resource "aws_key_pair" "tf-ssh-key" {
  key_name = "tf-ssh-key"
  public_key = file("~/.ssh/ec2.pub")
}

# Create security group to allow SSH connections in EC2 instances
resource "aws_security_group" "tf-sg-ec2-basic" {
  name        = "tf-sg-ec2-basic"
  description = "Allow SSH and HTTP"
  vpc_id = var.vpc.id

  # Default rules
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "tf-sg-efs-basic" {
  name        = "tf-sg-efs-basic"
  description = "Allow SSH and HTTP"
  vpc_id = var.vpc.id

  # Default rules
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Attach rule to enable access to port 22 of EC2 instance
resource "aws_security_group_rule" "tf-security-group-rule-ssh" {
  security_group_id = aws_security_group.tf-sg-ec2-basic.id
  type              = "ingress"
  to_port           = 22
  from_port         = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  depends_on = [
    aws_security_group.tf-sg-ec2-basic
  ]
}

# Attach rule to enable access to port 80 of EC2 instance
resource "aws_security_group_rule" "tf-security-group-rule-http" {
  security_group_id = aws_security_group.tf-sg-ec2-basic.id
  type              = "ingress"
  to_port           = 80
  from_port         = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  depends_on = [
    aws_security_group.tf-sg-ec2-basic
  ]
}

# Attach rule to enable access to port 2049 of EFS
resource "aws_security_group_rule" "tf-security-group-rule-nfs" {
  security_group_id = aws_security_group.tf-sg-efs-basic.id
  type              = "ingress"
  to_port           = 2049
  from_port         = 2049
  protocol          = "tcp"
  cidr_blocks = [var.vpc.cidr_block]
  depends_on = [
    aws_security_group.tf-sg-ec2-basic
  ]
}