# Cloud Provider Block & Credentials
provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_Access_Key
  secret_key = var.Aws_secret_key
  token      = var.aws_session_token
}

# Resource Block

# Create a VPC
resource "aws_vpc" "project_vpc" {
  cidr_block = var.aws_vpc_cidr
  tags       = var.common_tags
}

# Create a Subnet
resource "aws_subnet" "project_subnet" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = var.aws_subnet_cidr
  availability_zone       = var.aws_availability_zone
  map_public_ip_on_launch = true
}

# Create an Internet Gateway

resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.project_vpc.id
  tags = {
    environment = "production"
    owner       = "dammie"
  }
}

# Create a Route Table
resource "aws_route_table" "project_rt" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_igw.id
  }
  tags = {
    Name = "project_rt"
  }

  depends_on = [aws_internet_gateway.project_igw]
}

# Associate the Route Table with the Subnet

resource "aws_route_table_association" "project_rta" {
  subnet_id      = aws_subnet.project_subnet.id
  route_table_id = aws_route_table.project_rt.id
}

# Create a Security Group and an EC2 Instance
resource "aws_security_group" "project_sg_app" {
  name        = "project_sg_app"
  description = "Allow inbound traffic to app server"
  vpc_id      = aws_vpc.project_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "project_sg_app_server"
  }
}

# Create an EC2 Instance
resource "aws_instance" "app_server" {
  ami             = var.ami_id # Amazon Linux 2 AMI
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = aws_subnet.project_subnet.id
  security_groups = [aws_security_group.project_sg_app.id]

  tags = var.common_tags
}

