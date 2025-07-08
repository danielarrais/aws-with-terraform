output "main_vpc" {
  value = {
    id = aws_vpc.main.id
    cidr_block = aws_vpc.main.cidr_block
    subnets = {
      subnet_1a = {
        id = aws_subnet.public_1a.id
        cidr_block = aws_subnet.public_1a.cidr_block
      }
      subnet_1b = {
        id = aws_subnet.public_1b.id
        cidr_block = aws_subnet.public_1b.cidr_block
      }
      subnet_1c = {
        id = aws_subnet.public_1c.id
        cidr_block = aws_subnet.public_1c.cidr_block
      }
    }
  }                                       # The actual value to be outputted
  description = "The public IP address of the EC2 instance" # Description of what this output represents
}