resource "aws_vpc" "vpc4096ip" {
  cidr_block = "10.0.0.0/20"
}

resource "aws_subnet" "subnet256ip1" {
  vpc_id = aws_vpc.vpc4096ip.owner_id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "subnet256ip2" {
  vpc_id = aws_vpc.vpc4096ip.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "subnet256ip3" {
  vpc_id = aws_vpc.vpc4096ip.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet256ip4" {
  vpc_id = aws_vpc.vpc4096ip.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = true
}