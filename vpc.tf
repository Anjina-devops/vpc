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

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {
        
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id

  }

  tags = {
       Name = "roboshop-public"
  }

  
}

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id


  tags = {
       Name = "roboshop-private"
  }


}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
# create security group and allow port no 80 from public and 22 only from your laptop

resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_tls"
  description = "Allow tls inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    description = "https from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "ssh from my laptop"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["122.171.20.63/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_ssh"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0b4f379183e5706b9"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  security_groups = [aws_security_group.allow_http_ssh.name]
  associate_public_ip_address = true 


  tags = {
    Name = "web"
  }
}