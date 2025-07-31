output "alb-dns" {
  description = "DNS to access online the ALB"
  value   = aws_lb.tf-alb-ec2-instances.dns_name
}