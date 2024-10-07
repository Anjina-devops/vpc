resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags ={
    Name = "roboshop-vpc-terraform"
    Environment = "DEV"
    Terraform = "true"


  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-subnet-terraform"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private-subnet-terraform"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "roboshop-ig-terraform"
  }
}