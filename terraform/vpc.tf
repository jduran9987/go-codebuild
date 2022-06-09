resource "aws_vpc" "codebuild" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true 
  enable_dns_support = true
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.codebuild.id 
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.codebuild.id 
  cidr_block = "10.0.2.0/24"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.codebuild.id
}

resource "aws_eip" "ngw" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  subnet_id = aws_subnet.public.id

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.codebuild.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id 
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id 
  route_table_id = aws_route_table.public.id 
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.codebuild.id 

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id 
  route_table_id = aws_route_table.private.id 
}

resource "aws_security_group" "allow_egress" {
  name = "allow_egress"
  vpc_id = aws_vpc.codebuild.id 

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

