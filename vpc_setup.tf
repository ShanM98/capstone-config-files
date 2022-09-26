#vpc
resource "aws_vpc" "capstone-vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Capstone-VPC-1"
  }
}

#subnet
resource "aws_subnet" "capstone-subnet1" {
  vpc_id     = aws_vpc.capstone-vpc1.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-1a"
  tags = {
    Name = "Capstone-subnet-01"
  }
}

resource "aws_internet_gateway" "capstone-igw1" {
  vpc_id = aws_vpc.capstone-vpc1.id

  tags = {
    Name = "Capstone-igw"
  }
}

resource "aws_route_table" "capstone-public_rt" {
  vpc_id = aws_vpc.capstone-vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.capstone-igw1.id
  }

  tags = {
    Name = "Capstone-RT-Public"
  }
}

resource "aws_route_table_association" "capstone-public_rt1_asso" {
  subnet_id      = aws_subnet.capstone-subnet1.id
  route_table_id = aws_route_table.capstone-public_rt.id
}

resource "aws_security_group" "capstone-allow-all" {
  name        = "All Traffic"
  description = "All"
  vpc_id      = aws_vpc.capstone-vpc1.id

  ingress {
    description      = "All"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Capstone-All-Traffic"
  }
}


output "my_vpc_output" {
  value = aws_vpc.capstone-vpc1.id
}

output "my_subnet_output" {
  value = aws_subnet.capstone-subnet1.id
}

output "my_sg_output" {
  value = aws_security_group.capstone-allow-all.id
}