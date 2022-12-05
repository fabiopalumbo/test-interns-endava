#aqui coloco 0.0.0.0/19 pq com 20 da 4054 ips faltando 2 ips para chegar a
#4096 entao tenho que colocar 19, porem o rango de ips aumenta muito

resource "aws_vpc" "vpc-test-interns"{
   cidr_block= "10.0.0.0/19"  # aqui é onde voce coloca a quantidad de ips disponiveis em sua VPC
   tags={
    Name= "vpc-test-interns"
   }

}

resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.vpc-test-interns.id
  cidr_block = "10.0.0.0/23" # esa ip me da 510 ip's para minha subnet-1
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.vpc-test-interns.id
  cidr_block = "10.0.0.0/23" # esa ip me da 510 ip's para minha subnet-2
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.vpc-test-interns.id
  cidr_block = "10.0.0.0/23" # esa ip me da 510 ip's para minha subnet-2
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.vpc-test-interns.id
  cidr_block = "10.0.0.0/23" # esa ip me da 510 ip's para minha subnet-2
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-2"
  }
}
