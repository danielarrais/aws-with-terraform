resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# To allows the EC2  access the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Public subnet A
resource "aws_subnet" "public_1a" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Public subnet B
resource "aws_subnet" "public_1b" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

# Public subnet C
resource "aws_subnet" "public_1c" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
}

# Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate table with subnet 1a
resource "aws_route_table_association" "public_rta_1a" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_1a.id
}

# Associate table with subnet 1b
resource "aws_route_table_association" "public_rta_1b" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_1b.id
}

# Associate table with subnet 1c
resource "aws_route_table_association" "public_rta_1c" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_1c.id
}