# ALB
# Create a security group to ELB
resource "aws_security_group" "tf-sg-elb-basic" {
  name        = "tf-sg-elb-basic"
  description = "Allow HTTP traffic on ELB"
  vpc_id = var.vpc.id

  # Default rules
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Attach rule to enable access to port 80 of ELB
resource "aws_security_group_rule" "tf-sg-elb-rule-http" {
  security_group_id = aws_security_group.tf-sg-elb-basic.id
  type              = "ingress"
  to_port           = 80
  from_port         = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  depends_on = [
    aws_security_group.tf-sg-elb-basic
  ]
}