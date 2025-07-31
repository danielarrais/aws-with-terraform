# ALB
# Create a security group to ALB
resource "aws_security_group" "tf-sg-alb-basic" {
  name        = "tf-sg-alb-basic"
  description = "Allow HTTP traffic on ALB"
  vpc_id      = var.vpc.id

  # Default rules
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create target group
resource "aws_alb_target_group" "tf-tg-ec2-instances" {
  name     = "tf-tg-ec2-instances"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc.id
}

# Attach the ec2 instances to the target group
resource "aws_alb_target_group_attachment" "tf-lb-attachment-ec2-1" {
  target_group_arn = aws_alb_target_group.tf-tg-ec2-instances.arn
  target_id        = var.ec2_ids[0]
}

# Attach the ec2 instances to the target group
resource "aws_alb_target_group_attachment" "tf-lb-attachment-ec2-2" {
  target_group_arn = aws_alb_target_group.tf-tg-ec2-instances.arn
  target_id        = var.ec2_ids[1]
}

# Attach rule to enable access to port 80 of ALB
resource "aws_security_group_rule" "tf-sg-alb-rule-http" {
  security_group_id = aws_security_group.tf-sg-alb-basic.id
  type              = "ingress"
  description       = "Allow HTTP traffic on ALB"
  to_port           = 80
  from_port         = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  depends_on = [
    aws_security_group.tf-sg-alb-basic
  ]
}

# Create ALB
resource "aws_lb" "tf-alb-ec2-instances" {
  name               = "tf-alb-ec2-instances"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.tf-sg-alb-basic.id
  ]
  subnets = [
    var.vpc.subnets.subnet_1a.id,
    var.vpc.subnets.subnet_1b.id,
    var.vpc.subnets.subnet_1c.id
  ]
}

# Create listener to link the alb with the target-group
resource "aws_lb_listener" "tf-listener-ec2-target-group" {
  load_balancer_arn = aws_lb.tf-alb-ec2-instances.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.tf-tg-ec2-instances.arn
  }
}